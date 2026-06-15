# Notes

## Boot Chain

| Stage | Owner | Input | Output | Evidence |
|---|---|---|---|---|
| Boot ROM | | | | |
| Firmware | | | | |
| Bootloader | | | | |
| Kernel entry | | | | |
| Driver init | | | | |
| Rootfs | | | | |
| User space | | | | |

## Open Questions

- Which timestamp source starts first?
- Which stage selects the DTB?
- Which stage owns the longest unknown gap?
