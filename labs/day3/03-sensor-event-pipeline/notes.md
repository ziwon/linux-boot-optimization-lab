# Notes

## Event Path

```text
hardware event
  -> IRQ
  -> driver
  -> buffer or input event
  -> user-space service
  -> product action
```

## Timing Points

| Point | Timestamp Source | Evidence |
|---|---|---|
| IRQ | | |
| Driver read | | |
| User-space receive | | |
| Product action | | |
