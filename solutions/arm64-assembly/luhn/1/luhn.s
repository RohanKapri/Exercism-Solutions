.text
.globl valid

valid:
        mov     x1, x0
        mov     x2, #0
        mov     x3, #0

first_scan:
        ldrb    w4, [x1], #1
        cbz     w4, end_first_scan

        cmp     w4, #' '
        beq     first_scan

        sub     w4, w4, #'0'
        cmp     w4, #10
        bhs     reject

        add     x2, x2, #1
        b       first_scan

end_first_scan:
        mov     x1, x0
        cmp     x2, #2
        blt     reject

second_scan:
        ldrb    w4, [x1], #1
        cbz     w4, end_second_scan

        cmp     w4, #' '
        beq     second_scan

        sub     w4, w4, #'0'
        tst     x2, #1
        bne     double_digit

        lsl     w4, w4, #1
        cmp     w4, #10
        blo     add_sum
        sub     w4, w4, #9

double_digit:
add_sum:
        add     x3, x3, x4
        sub     x2, x2, #1
        b       second_scan

end_second_scan:
        mov     x4, #10
        udiv    x5, x3, x4
        msub    x0, x5, x4, x3

        cmp     x0, xzr
        cset    x0, eq
        ret

reject:
        mov     x0, #0
        ret
