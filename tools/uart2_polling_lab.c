#define _POSIX_C_SOURCE 200809L

#include <errno.h>
#include <fcntl.h>
#include <signal.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <termios.h>
#include <time.h>
#include <unistd.h>

#define FCY_HZ 40000000UL
#define BAUD_RATE 9600UL
#define U2BRG_VALUE ((FCY_HZ / (16UL * BAUD_RATE)) - 1UL)

#define U2STA_URXDA (1u << 0)
#define U2STA_TRMT  (1u << 1)
#define U2STA_UTXBF (1u << 2)

struct uart2_model {
    uint16_t U2MODE;
    uint16_t U2STA;
    uint16_t U2BRG;
    uint8_t U2RXREG;
    uint8_t U2TXREG;
};

static struct termios saved_termios;
static bool saved_termios_valid;
static volatile sig_atomic_t keep_running = 1;

static void restore_terminal(void)
{
    if (saved_termios_valid) {
        tcsetattr(STDIN_FILENO, TCSANOW, &saved_termios);
    }
}

static void handle_signal(int signo)
{
    (void)signo;
    keep_running = 0;
}

static void configure_terminal(void)
{
    struct termios raw;
    int flags;

    if (!isatty(STDIN_FILENO)) {
        fprintf(stderr, "stdin is not a TTY. Run this lab from an interactive shell.\n");
        exit(1);
    }

    if (tcgetattr(STDIN_FILENO, &saved_termios) != 0) {
        perror("tcgetattr");
        exit(1);
    }

    saved_termios_valid = true;
    atexit(restore_terminal);

    raw = saved_termios;
    raw.c_lflag &= (tcflag_t)~(ICANON | ECHO);
    raw.c_cc[VMIN] = 0;
    raw.c_cc[VTIME] = 0;

    if (tcsetattr(STDIN_FILENO, TCSANOW, &raw) != 0) {
        perror("tcsetattr");
        exit(1);
    }

    flags = fcntl(STDIN_FILENO, F_GETFL, 0);
    if (flags < 0 || fcntl(STDIN_FILENO, F_SETFL, flags | O_NONBLOCK) != 0) {
        perror("fcntl");
        exit(1);
    }
}

static void uart2_init(struct uart2_model *uart)
{
    memset(uart, 0, sizeof(*uart));
    uart->U2BRG = (uint16_t)U2BRG_VALUE;
    uart->U2MODE = 0x8000; /* UARTEN: 8-bit data, no parity, 1 stop bit in this model. */
    uart->U2STA = U2STA_TRMT;
}

static bool uart2_poll_rx(struct uart2_model *uart)
{
    unsigned char ch;
    ssize_t nread = read(STDIN_FILENO, &ch, 1);

    if (nread == 1) {
        uart->U2RXREG = ch;
        uart->U2STA |= U2STA_URXDA;
        return true;
    }

    if (nread < 0 && errno != EAGAIN && errno != EWOULDBLOCK) {
        perror("read");
        keep_running = 0;
    }

    return false;
}

static uint8_t uart2_read(struct uart2_model *uart)
{
    uart->U2STA &= (uint16_t)~U2STA_URXDA;
    return uart->U2RXREG;
}

static void sleep_ns(long ns)
{
    struct timespec ts = {
        .tv_sec = 0,
        .tv_nsec = ns,
    };
    nanosleep(&ts, NULL);
}

static void uart2_write_char(struct uart2_model *uart, char ch)
{
    while ((uart->U2STA & U2STA_UTXBF) != 0) {
        sleep_ns(100000L);
    }

    uart->U2STA |= U2STA_UTXBF;
    uart->U2STA &= (uint16_t)~U2STA_TRMT;
    uart->U2TXREG = (uint8_t)ch;

    if (write(STDOUT_FILENO, &ch, 1) != 1) {
        keep_running = 0;
    }

    uart->U2STA &= (uint16_t)~U2STA_UTXBF;
    uart->U2STA |= U2STA_TRMT;
}

static void uart2_write_string(struct uart2_model *uart, const char *s)
{
    while (*s != '\0') {
        uart2_write_char(uart, *s++);
    }
}

static void sleep_for_poll_interval(void)
{
    sleep_ns(10000000L);
}

int main(void)
{
    struct uart2_model uart2;

    signal(SIGINT, handle_signal);
    signal(SIGTERM, handle_signal);

    configure_terminal();
    uart2_init(&uart2);

    printf("UART2 polling lab: FCY=%lu Hz, baud=%lu, U2BRG=%u\n",
           FCY_HZ, BAUD_RATE, uart2.U2BRG);
    printf("Press SPACE to transmit the message. Press q to quit.\n\n");
    fflush(stdout);

    while (keep_running) {
        if (uart2_poll_rx(&uart2) && (uart2.U2STA & U2STA_URXDA) != 0) {
            uint8_t rx = uart2_read(&uart2);

            if (rx == 0x20) {
                uart2_write_string(&uart2,
                                   "\r\n[UART2 TX] SPACE detected: Hello from dsPIC33FJ256GP710 polling model\r\n");
            } else if (rx == 'q' || rx == 'Q') {
                keep_running = 0;
            } else {
                printf("\r\n[UART2 RX] ignored byte: 0x%02X\r\n", rx);
                fflush(stdout);
            }
        }

        sleep_for_poll_interval();
    }

    printf("\r\nUART2 polling lab stopped.\r\n");
    return 0;
}
