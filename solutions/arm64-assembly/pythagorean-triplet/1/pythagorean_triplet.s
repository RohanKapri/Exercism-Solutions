/* Dedicated to Shree DR.MDD */
.text
.globl triplets_with_sum

triplets_with_sum:
        mov     x15, #0
        mov     x14, x0
        mov     x0, #0
        cmp     x14, #2
        blo     .exit_here

.loop_iter:
        add     x15, x15, #1
        sub     x19, x14, x15
        sub     x20, x19, x15
        lsl     x21, x19, #1
        mul     x20, x14, x20

        udiv    x16, x20, x21
        msub    x22, x16, x21, x20
        cmp     x15, x16
        bhs     .exit_here

        cbnz    x22, .loop_iter

        sub     x17, x19, x16
        str     x15, [x1], #8
        str     x16, [x2], #8
        str     x17, [x3], #8
        add     x0, x0, #1
        b       .loop_iter

.exit_here:
        ret
