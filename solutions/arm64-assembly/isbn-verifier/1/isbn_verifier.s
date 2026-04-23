// Dedicated to Shree DR.MDD

.text
.globl is_valid

is_valid:
        mov     w8, #10
        mov     w9, #0
        mov     w10, #0

validate_loop:
        ldrb    w6, [x0], #1
        cbz     w6, finish_check

        cmp     w6, #45
        beq     validate_loop

        sub     w8, w8, #1
        sub     w7, w6, #'0'
        cmp     w7, #10
        bhs     handle_non_digit

accumulate:
        add     w9, w9, w7
        add     w10, w10, w9
        b       validate_loop

handle_non_digit:
        cbnz    w8, reject_isbn

        mov     w7, #10
        cmp     w6, #'X'
        beq     accumulate

reject_isbn:
        mov     w0, #0
        ret

finish_check:
        cbnz    w8, reject_isbn

        mov     w8, #11
        udiv    w9, w10, w8
        msub    w7, w9, w8, w10
        tst     w7, w7
        cset    w0, eq
        ret
