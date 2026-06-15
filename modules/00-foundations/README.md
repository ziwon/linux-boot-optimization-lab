# Module 00 — Foundations for Kernel Bring-up Engineers

## Mental model

Embedded Linux boot is a chain of contracts. Each stage prepares the world for the next stage:

1. The CPU reset vector starts immutable ROM or early firmware.
2. Firmware configures minimal clocks, memory, and security state.
3. The bootloader loads images, verifies them if needed, prepares the device tree, and jumps to the kernel.
4. The kernel initializes CPU, memory, scheduler, IRQs, timers, driver model, filesystems, and user space.
5. User space starts services and makes the product usable.

A boot failure usually means one contract was violated.

## Essential vocabulary

- **BSP**: The board-specific package that makes an OS run on a board. It may include bootloader patches, device tree, kernel defconfig, drivers, firmware blobs, and vendor scripts.
- **SoC**: System-on-Chip. CPU cores plus many integrated peripherals.
- **Board**: The actual product PCB. A SoC can be reused across many boards with different sensors, PMICs, memory, display panels, and IO routing.
- **Device Tree**: Data structure that describes non-discoverable hardware to the kernel.
- **Probe**: The moment a driver binds to a device and initializes it.
- **initcall**: Kernel initialization function registered into ordered sections.
- **Deferred probe**: A driver tried to initialize, but a dependency such as clock, regulator, GPIO, PHY, or supplier device was not ready.

## Kernel engineer habits

- Keep a timeline.
- Keep the original log.
- Change one variable at a time.
- Prefer small reversible patches.
- Explain evidence before opinion.
- Never hide a hardware timing issue by “optimizing” around it.
