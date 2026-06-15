# Review Questions

1. What are the main responsibilities of a BSP engineer?
2. How do Boot ROM, SPL, U-Boot, and the Linux kernel divide responsibilities?
3. Why is Device Tree needed?
4. What do U-Boot `bootcmd`, `bootargs`, and `fdt_addr` do?
5. Why does the Linux kernel split initialization into initcall levels?
6. How are platform devices matched with platform drivers?
7. What symptoms can appear when a `compatible` string does not match any driver?
8. What information does `initcall_debug` provide?
9. What are common causes of deferred probe?
10. What should you check before enabling async probe?
11. In boot-time optimization, should measurement or tuning come first?
12. Why can kernel configuration affect boot time?
13. How can you separate U-Boot delay from Linux kernel delay?
14. How can ftrace help identify device-driver initialization bottlenecks?
15. What regression tests are required after optimizing boot time on a product?
