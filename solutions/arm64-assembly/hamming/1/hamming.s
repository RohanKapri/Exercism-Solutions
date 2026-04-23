// Dedicated to Shree DR.MDD

.equ UNEQUAL_LENGTHS, -1

.text
.globl distance

distance:
        mov     x5, x0
        mov     x0, #0

.compare_loop:
        ldrb    w6, [x1], #1
        ldrb    w7, [x5], #1

        cbz     w6, .end_check
        cbz     w7, .end_check

        cmp     w6, w7
        cinc    x0, x0, ne
        b       .compare_loop

.end_check:
        cmp     w6, w7
        beq     .finish

        mov     x0, UNEQUAL_LENGTHS

.finish:
        ret
