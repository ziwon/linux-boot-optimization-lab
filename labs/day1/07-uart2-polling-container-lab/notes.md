# Notes

## Baud-rate calculation

```text
Fcy = 40,000,000 Hz
Baud = 9,600 bps
U2BRG = Fcy / (16 * Baud) - 1
      = 259
```

## Register mapping

| Register or bit | Meaning | Where it appears in the lab |
|---|---|---|
| `U2MODE` | UART2 mode register. On real hardware this enables UART and selects framing such as 8-bit data, no parity, and 1 stop bit. | `uart2_init()` sets `uart->U2MODE = 0x8000` to model UART enable. |
| `U2STA.URXDA` | UART2 receive data available flag. It becomes set when at least one received byte is ready to read. | `uart2_poll_rx()` sets `U2STA_URXDA` after reading a terminal byte. `main()` checks this flag before reading RX data. |
| `U2STA.UTXBF` | UART2 transmit buffer full flag. If this is set, firmware should wait before writing another TX byte. | `uart2_write_char()` waits while `U2STA_UTXBF` is set, then sets it while writing one character. |
| `U2STA.TRMT` | UART2 transmitter empty/complete flag. It indicates that transmission has completed. | `uart2_init()` starts with `U2STA_TRMT` set. `uart2_write_char()` clears it during transmit and sets it again after output. |
| `U2BRG` | UART2 baud-rate generator register. Its value is calculated from `Fcy` and the target baud rate. | `uart2_init()` assigns `U2BRG_VALUE`, which is calculated from `40 MHz`, `9600 bps`, and the 16x UART divisor. |
| `U2RXREG` | UART2 receive register. Firmware reads this register to get the received byte. | `uart2_poll_rx()` copies the terminal byte into `uart->U2RXREG`. `uart2_read()` returns it and clears `URXDA`. |
| `U2TXREG` | UART2 transmit register. Firmware writes this register to transmit a byte. | `uart2_write_char()` copies each output character into `uart->U2TXREG` before writing it to the terminal. |

## Polling flow

```text
terminal key input
  -> UART2 RX model
  -> check RX flag
  -> read byte
  -> compare with 0x20
  -> wait for TX availability
  -> write response string
```

## Open questions

- Which behavior would be different on the real dsPIC33 board?

  On the real dsPIC33 board, UART2 is physical hardware connected to pins, level shifters, cables, and a PC serial terminal. Baud-rate error, oscillator accuracy, pin configuration, electrical wiring, overrun errors, framing errors, and actual TX/RX timing can affect communication. In this container lab, the terminal input/output only models the firmware control flow; it does not emulate the dsPIC33 CPU, UART peripheral timing, or electrical serial waveform.

- Which behavior would be similar enough for firmware logic practice?

  The important software logic is similar: initialize UART-related state, calculate the baud-rate register from `Fcy`, poll the receive-ready flag, read the RX byte, compare it with SPACE (`0x20`), wait for TX availability, and write a response string. This is enough to practice the structure of polling-mode UART firmware before moving to the real board.

- Where would an interrupt handler replace the polling loop?

  In interrupt mode, the repeated RX check inside `main()` would be replaced by a UART RX interrupt service routine. Instead of the main loop continuously checking `URXDA`, the UART hardware would raise an interrupt when a byte arrives. The ISR would read `U2RXREG`, check whether the byte is `0x20`, and either transmit directly or signal the main loop to send the response.
