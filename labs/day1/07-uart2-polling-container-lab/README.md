# Lab 1-7 — UART2 Polling in a Container

## Objective

Understand the core control flow of a dsPIC33FJ256GP710 UART2 polling lab without requiring the physical board, MPLAB IDE, or HyperTerminal.

This lab models the important parts of the original experiment:

- `Fosc = 80 MHz`, `Fcy = 40 MHz`
- UART2, 9600 bps, 8 data bits, no parity, 1 stop bit
- polling receive instead of interrupt-driven receive
- SPACE key detection using ASCII `0x20`
- transmit a fixed string when SPACE is received

## What is simulated

The program in `tools/uart2_polling_lab.c` creates a small UART2 register model:

| dsPIC33 concept | Lab model |
|---|---|
| `U2MODE` | UART enable and framing concept |
| `U2STA.URXDA` | input byte is available |
| `U2STA.UTXBF` | transmit buffer is busy |
| `U2STA.TRMT` | transmit shift register is empty |
| `U2BRG` | baud-rate generator value |
| `U2RXREG` | received terminal byte |
| `U2TXREG` | byte written to terminal output |

The terminal inside the container acts as the PC serial terminal.

## Build and run

From the repository root:

```bash
make build-uart-polling-lab
make run-uart-polling-lab
```

Or inside Docker:

```bash
make docker-build
make docker-shell
make build-uart-polling-lab
make run-uart-polling-lab
```

When the lab starts:

1. Press normal keys and observe ignored RX bytes.
2. Press SPACE and observe the transmitted message.
3. Press `q` to exit.

## Tasks

1. Calculate the UART baud-rate generator value using `Fcy = 40 MHz`.
2. Confirm why `U2BRG = 259` is close enough for 9600 bps in this model.
3. Trace the polling loop from RX check to SPACE comparison to TX output.
4. Change the trigger key from SPACE (`0x20`) to ENTER (`0x0D` or `0x0A`) and rebuild.
5. Add a counter that prints how many SPACE events were detected.
6. Explain what CPU time is wasted by polling compared with an interrupt-driven UART.

## Practice questions

- Why does UART baud-rate calculation use `Fcy`, not `Fosc`?
- What happens if the terminal and UART baud-rate settings do not match on real hardware?
- Which part of the loop corresponds to checking `URXDA`?
- Which part corresponds to waiting until TX is available?
- Why is this lab useful even though it does not emulate dsPIC33 instruction execution?

## Deliverable

Fill in `result.md` with:

- baud-rate calculation
- observed SPACE behavior
- one code change you made
- a short comparison of polling and interrupt mode
