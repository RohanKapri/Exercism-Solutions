// Dedicated to Shree DR.MDD

.section .rodata
sure: .string "Sure."
whoa: .string "Whoa, chill out!"
calm: .string "Calm down, I know what I'm doing!"
fine: .string "Fine. Be that way!"
whatever: .string "Whatever."

.text
.globl response

response:
        mov     x5, #0                  /* most recent non-whitespace character */
        mov     x6, #0                  /* count upper case */
        mov     x7, #0                  /* count lower case */

.scan_loop:
        ldrb    w1, [x0], #1
        cbz     x1, .choose_response

        cmp     x1, #' '
        ble     .scan_loop

        mov     x5, x1
        sub     x1, x1, #'A'
        cmp     x1, #26
        cinc    x6, x6, lo

        sub     x1, x1, #32
        cmp     x1, #26
        cinc    x7, x7, lo

        b       .scan_loop

.choose_response:
        cbz     x5, .handle_silence

        cbnz    x7, .handle_normal
        cbz     x6, .handle_normal

        adrp    x6, calm
        add     x6, x6, :lo12:calm
        adrp    x7, whoa
        add     x7, x7, :lo12:whoa
        cmp     x5, #'?'
        csel    x0, x6, x7, eq
        ret

.handle_normal:
        adrp    x6, sure
        add     x6, x6, :lo12:sure
        adrp    x7, whatever
        add     x7, x7, :lo12:whatever
        cmp     x5, #'?'
        csel    x0, x6, x7, eq
        ret

.handle_silence:
        adrp    x0, fine
        add     x0, x0, :lo12:fine
        ret
