#!/usr/bin/env bash
#
# Build "PerKate - The Perfect Hekate Zip" from official upstream releases.
#
# - Downloads the exact pinned hekate + Nyx and Atmosphère releases.
# - Verifies the SHA-256 of every downloaded asset.
# - Assembles a microSD-root tree (no extra top-level folder).
# - Creates the final ZIP and checks it (unzip -t + extraction diff).
#
# Usage: bash scripts/build-perkate.sh
# Output: dist/PerKate - The Perfect Hekate Zip.zip (+ .sha256)

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BUILD_DIR="${BUILD_DIR:-$ROOT_DIR/build}"
DIST_DIR="${DIST_DIR:-$ROOT_DIR/dist}"
PACK_SRC="$ROOT_DIR/pack"

ZIP_NAME="PerKate - The Perfect Hekate Zip.zip"

# --- Pinned upstream versions -------------------------------------------
HEKATE_TAG="v6.5.4"
HEKATE_PAYLOAD="hekate_ctcaer_6.5.4.bin"
HEKATE_NYX_ZIP="hekate_ctcaer_6.5.4_Nyx_1.9.4.zip"
HEKATE_PAYLOAD_SHA256="95f6e933e32e028f3ae90f0b0857ff47800e834bdace38a0ab019d8ed35a8c24"
HEKATE_NYX_ZIP_SHA256="a5ee4faa956f1ffe49fdd31d795be3fd556c8dffd9cbed69cec7cff92b8b43f6"

AMS_TAG="1.12.0"
AMS_ZIP="atmosphere-1.12.0-master-28d6a2e11+hbl-2.4.5+hbmenu-3.6.1.zip"
AMS_ZIP_URL_NAME="atmosphere-1.12.0-master-28d6a2e11%2Bhbl-2.4.5%2Bhbmenu-3.6.1.zip"
AMS_FUSEE="fusee.bin"
AMS_ZIP_SHA256="14451a033935962a9ed800db6918706e372de4370e8d04ea3fc9728a937249e1"
AMS_FUSEE_SHA256="6559017e4df5ac418ce09fb347c32d071649f8b6d3d4bac9a874505fc8bed1bd"

HEKATE_RELEASE_URL="https://github.com/CTCaer/hekate/releases/download/${HEKATE_TAG}"
AMS_RELEASE_URL="https://github.com/Atmosphere-NX/Atmosphere/releases/download/${AMS_TAG}"

USER_AGENT="PerKate-build/1.0 (+https://github.com/ClmentCch/PerKate---The-Perfect-Hekate-Zip)"

# Deterministic timestamps/permissions inside the ZIP.
FIXED_DATE="2026-11-08 00:00:00 UTC"

DL_DIR="$BUILD_DIR/downloads"
SD_DIR="$BUILD_DIR/sd"
EXTRACT_DIR="$BUILD_DIR/extract"
CHECK_DIR="$BUILD_DIR/check"

log() { printf '\n==> %s\n' "$*"; }
fail() { printf 'ERROR: %s\n' "$*" >&2; exit 1; }

sha256_of() { sha256sum "$1" | awk '{print $1}'; }

download() {
  local url="$1" out="$2" expected="$3"
  mkdir -p "$(dirname "$out")"
  if [[ -f "$out" && "$(sha256_of "$out")" == "$expected" ]]; then
    log "Using cached $(basename "$out")"
    return 0
  fi
  log "Downloading $(basename "$out")"
  curl -fsSL --retry 3 --retry-delay 2 -A "$USER_AGENT" -o "$out.part" "$url"
  local actual
  actual="$(sha256_of "$out.part")"
  if [[ "$actual" != "$expected" ]]; then
    rm -f "$out.part"
    fail "SHA-256 mismatch for $(basename "$out"): got $actual, expected $expected"
  fi
  mv "$out.part" "$out"
}

verify_sha256() {
  local file="$1" expected="$2" actual
  [[ -s "$file" ]] || fail "Missing or empty file: $file"
  actual="$(sha256_of "$file")"
  [[ "$actual" == "$expected" ]] || fail "SHA-256 mismatch for $file: got $actual, expected $expected"
}

# --- Download + verify upstream assets ----------------------------------
mkdir -p "$DL_DIR"
download "$HEKATE_RELEASE_URL/$HEKATE_PAYLOAD" "$DL_DIR/$HEKATE_PAYLOAD" "$HEKATE_PAYLOAD_SHA256"
download "$HEKATE_RELEASE_URL/$HEKATE_NYX_ZIP" "$DL_DIR/$HEKATE_NYX_ZIP" "$HEKATE_NYX_ZIP_SHA256"
download "$AMS_RELEASE_URL/$AMS_ZIP_URL_NAME" "$DL_DIR/$AMS_ZIP" "$AMS_ZIP_SHA256"
download "$AMS_RELEASE_URL/$AMS_FUSEE" "$DL_DIR/$AMS_FUSEE" "$AMS_FUSEE_SHA256"

# --- Extract official archives ------------------------------------------
log "Extracting official archives"
rm -rf "$EXTRACT_DIR" "$SD_DIR"
mkdir -p "$EXTRACT_DIR/hekate" "$EXTRACT_DIR/atmosphere" "$SD_DIR"
unzip -q "$DL_DIR/$HEKATE_NYX_ZIP" -d "$EXTRACT_DIR/hekate"
unzip -q "$DL_DIR/$AMS_ZIP" -d "$EXTRACT_DIR/atmosphere"

# --- Assemble the SD-card root ------------------------------------------
log "Assembling microSD tree"
cp -a "$EXTRACT_DIR/atmosphere/." "$SD_DIR/"
cp -a "$EXTRACT_DIR/hekate/bootloader" "$SD_DIR/"
cp -a "$DL_DIR/$HEKATE_PAYLOAD" "$SD_DIR/$HEKATE_PAYLOAD"
cp -a "$DL_DIR/$AMS_FUSEE" "$SD_DIR/$AMS_FUSEE"
mkdir -p "$SD_DIR/bootloader/payloads"
cp -a "$DL_DIR/$AMS_FUSEE" "$SD_DIR/bootloader/payloads/$AMS_FUSEE"
cp -a "$PACK_SRC/README.txt" "$SD_DIR/README.txt"
cp -a "$PACK_SRC/hekate_ipl.ini" "$SD_DIR/bootloader/hekate_ipl.ini"

# Normalize permissions and timestamps for a clean, reproducible archive.
find "$SD_DIR" -type d -exec chmod 755 {} +
find "$SD_DIR" -type f -exec chmod 644 {} +
TZ=UTC find "$SD_DIR" -exec touch -d "$FIXED_DATE" {} +

# --- Structural checks ---------------------------------------------------
log "Checking package structure"
for f in \
  "$SD_DIR/README.txt" \
  "$SD_DIR/hbmenu.nro" \
  "$SD_DIR/fusee.bin" \
  "$SD_DIR/$HEKATE_PAYLOAD" \
  "$SD_DIR/atmosphere/package3" \
  "$SD_DIR/atmosphere/reboot_payload.bin" \
  "$SD_DIR/bootloader/hekate_ipl.ini" \
  "$SD_DIR/bootloader/sys/nyx.bin" \
  "$SD_DIR/bootloader/sys/res.pak" \
  "$SD_DIR/bootloader/update.bin" \
  "$SD_DIR/bootloader/payloads/fusee.bin"; do
  [[ -s "$f" ]] || fail "Required file missing or empty: ${f#"$SD_DIR"/}"
done

if find "$SD_DIR" -type f -empty -print -quit | grep -q .; then
  fail "Empty file found in package"
fi
cmp -s "$SD_DIR/fusee.bin" "$SD_DIR/atmosphere/reboot_payload.bin" \
  || fail "fusee.bin and atmosphere/reboot_payload.bin differ"
cmp -s "$SD_DIR/fusee.bin" "$SD_DIR/bootloader/payloads/fusee.bin" \
  || fail "bootloader/payloads/fusee.bin differs from fusee.bin"
cmp -s "$SD_DIR/$HEKATE_PAYLOAD" "$SD_DIR/bootloader/update.bin" \
  || fail "bootloader/update.bin differs from the hekate payload"

[[ "$(sha256_of "$SD_DIR/atmosphere/package3")" == "3cc9d6ca5688e403c36974bced1089397ef8b36a4252f720207ae3d41a6eb557" ]] \
  || fail "atmosphere/package3 does not match Atmosphère ${AMS_TAG}"
[[ "$(sha256_of "$SD_DIR/bootloader/sys/nyx.bin")" == "441d4ca58099f277de76c90c172f2804e9a809ec1db44ca6a011b0a92b93a4f4" ]] \
  || fail "bootloader/sys/nyx.bin does not match Nyx from hekate ${HEKATE_TAG}"

# --- Build the ZIP -------------------------------------------------------
log "Creating $ZIP_NAME"
mkdir -p "$DIST_DIR"
rm -f "$DIST_DIR/$ZIP_NAME" "$DIST_DIR/$ZIP_NAME.sha256"
(
  cd "$SD_DIR"
  find . -mindepth 1 -print | sed 's|^\./||' | LC_ALL=C sort \
    | zip -X -9 -q "$DIST_DIR/$ZIP_NAME" -@
)

# --- Test the archive ----------------------------------------------------
log "Testing archive integrity"
unzip -t "$DIST_DIR/$ZIP_NAME" >/dev/null
rm -rf "$CHECK_DIR"
mkdir -p "$CHECK_DIR"
unzip -q "$DIST_DIR/$ZIP_NAME" -d "$CHECK_DIR"
diff -r "$SD_DIR" "$CHECK_DIR" >/dev/null || fail "Extracted ZIP differs from the assembled tree"
[[ "$(unzip -Z1 "$DIST_DIR/$ZIP_NAME" | grep -c '^\./')" == "0" ]] \
  || fail "ZIP contains ./ prefixed paths"
if unzip -Z1 "$DIST_DIR/$ZIP_NAME" | grep -qE '(^|/)(__MACOSX|\.DS_Store|Thumbs\.db)'; then
  fail "ZIP contains temporary/OS metadata"
fi

# --- Reports -------------------------------------------------------------
log "Writing SHA-256 reports"
(
  cd "$DIST_DIR"
  sha256sum "$ZIP_NAME" | tee "$ZIP_NAME.sha256"
  {
    echo "# Upstream component SHA-256"
    echo "$HEKATE_PAYLOAD_SHA256  $HEKATE_PAYLOAD"
    echo "$HEKATE_NYX_ZIP_SHA256  $HEKATE_NYX_ZIP"
    echo "$AMS_ZIP_SHA256  $AMS_ZIP"
    echo "$AMS_FUSEE_SHA256  $AMS_FUSEE"
    echo
    echo "# Final package"
    sha256sum "$ZIP_NAME"
  } > SHA256SUMS.txt
)

FILE_COUNT="$(find "$SD_DIR" -type f | wc -l | tr -d ' ')"
ZIP_SIZE="$(stat -c%s "$DIST_DIR/$ZIP_NAME")"
log "Done"
printf 'Files:      %s\n' "$FILE_COUNT"
printf 'ZIP size:   %s bytes\n' "$ZIP_SIZE"
printf 'ZIP path:   %s\n' "$DIST_DIR/$ZIP_NAME"
printf 'SHA-256:    %s\n' "$(sha256_of "$DIST_DIR/$ZIP_NAME")"
