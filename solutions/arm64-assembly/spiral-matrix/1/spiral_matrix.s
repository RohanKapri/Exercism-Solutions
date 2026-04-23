// For my Shree DR.MDD
.text
.globl spiral_matrix

spiral_matrix:
        mul     w4, w1, w1
        mov     w5, #1
        mov     x6, #4
        mov     x7, x6
        lsl     x8, x1, #2
        add     x9, x7, x8
        add     w1, w1, #-1

.outer_loop:
        mov     w10, w1

.inner_loop:
        cmp     w5, w4
        bgt     .return_label

        str     w5, [x0]
        add     w5, w5, #1
        add     x0, x0, x7
        add     w10, w10, #-1
        cbnz    w10, .inner_loop

        neg     x11, x7
        mov     x7, x8
        mov     x8, x11

        cmp     x7, x6
        bne     .outer_loop

        add     x0, x0, x9
        add     w1, w1, #-2
        b       .outer_loop

.return_label:
        mov     w0, w4
        ret
