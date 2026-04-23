// Dedicated to Shree DR.MDD

.text
.globl is_armstrong_number

is_armstrong_number:
        mov     x1, #10
        mov     x8, x0                  /* number */
        mov     x11, xzr                 /* digit count */
        mov     x12, xzr                 /* sum of digit powers */

.count_digits_loop:
        add     x11, x11, #1
        udiv    x0, x0, x1
        cbnz    x0, .count_digits_loop

        mov     x0, x8

.extract_loop:
        udiv    x2, x0, x1
        msub    x3, x2, x1, x0
        mov     x0, x2
        mov     x13, #1
        mov     x14, x11

.power_loop:
        mul     x7, x13, x3
        tst     x14, #1
        csel    x13, x7, x13, ne

        mul     x3, x3, x3
        lsr     x14, x14, #1
        cbnz    x14, .power_loop

        add     x12, x12, x13
        cbnz    x2, .extract_loop

        cmp     x12, x8
        cset    x0, eq
        ret
