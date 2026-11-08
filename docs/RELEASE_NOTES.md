PerKate - The Perfect Hekate Zip.

The all-in-one Hekate, Nyx and Atmosphère SD card package.

Features:

* Hekate bootloader.
* Nyx graphical interface.
* Atmosphère support.
* Organized SD card structure.
* French installation documentation.
* Verified package integrity.

## Components

| Component | Version | Files |
| --- | --- | --- |
| hekate | v6.5.4 | `hekate_ctcaer_6.5.4.bin`, `bootloader/` |
| Nyx | v1.9.4 | `bootloader/sys/nyx.bin`, `res.pak`, resources |
| Atmosphère | 1.12.0 | `atmosphere/package3`, `fusee.bin`, `hbmenu.nro` |
| hbl / hbmenu | 2.4.5 / 3.6.1 | bundled in the official Atmosphère release |

Official sources:

* https://github.com/CTCaer/hekate/releases/tag/v6.5.4
* https://github.com/Atmosphere-NX/Atmosphere/releases/tag/1.12.0

## Installation

1. Back up your microSD card.
2. Extract the ZIP **at the root** of the microSD card (the ZIP has no extra top-level folder).
3. Inject `hekate_ctcaer_6.5.4.bin` (RCM) or let your modchip load it.
4. In Nyx, choose `Nintendo Stock (SYSNAND)` or `Atmosphere SYSNAND`.

The package targets the internal memory only (no emuMMC). No Android entry is
included or invented; an existing switchroot installation and its
`bootloader/ini/` entries are preserved. Read `README.txt` inside the ZIP before
installing, especially if Android is already installed.

## Included boot entries

* `Nintendo Stock (SYSNAND)` — hekate stock mode on internal memory, closest to
  OFW but **not** a 100% official Nintendo boot.
* `Atmosphere SYSNAND` — Atmosphère CFW on internal memory.

No keys, NAND dumps, Nintendo firmware, games or copyrighted content are included.

## Integrity

Every upstream asset was verified against the SHA-256 published for its official
GitHub release. The final ZIP integrity is verified with `unzip -t` and a full
extraction diff before publication. The ZIP SHA-256 is appended below.
