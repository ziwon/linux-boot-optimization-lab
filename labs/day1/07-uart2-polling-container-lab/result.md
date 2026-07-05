# Result

## Baud-rate calculation

```text
Fcy = 40,000,000 Hz
Baud = 9,600 bps
U2BRG = Fcy / (16 * Baud) - 1
      = 40,000,000 / (16 * 9,600) - 1
      = 259.416...
      = 259 when stored as an integer register value
Actual baud estimate = 40,000,000 / (16 * (259 + 1))
                     = 9,615.38 bps
Error = about +0.16%
```

## Observation

```text
Command:
make run-uart-polling-lab

Input tested:
SPACE, then q

Output observed:
UART2 polling lab: FCY=40000000 Hz, baud=9600, U2BRG=259
Press SPACE to transmit the message. Press q to quit.

[UART2 TX] SPACE detected: Hello from dsPIC33FJ256GP710 polling model

UART2 polling lab stopped.
```

## Code change

```text
Change made:
No code change was required for the first run. The stock lab program was built
and executed.

Result:
The UART2 polling model detected SPACE as ASCII 0x20, transmitted the response
string, and exited when q was entered.
```

## Polling vs interrupt

```text
Polling:
The main loop repeatedly checks whether RX data is available. This is simple
and easy to understand, but the CPU keeps spending time checking the UART state.

Interrupt:
The CPU can do other work or sleep until the UART hardware raises an interrupt
when RX data arrives.

Conclusion:
This container lab confirms the core firmware control flow: initialize UART2,
poll RX status, compare the received byte with SPACE, wait for TX availability,
and transmit a string.
```
