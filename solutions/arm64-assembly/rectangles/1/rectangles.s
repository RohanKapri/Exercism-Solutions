/* Dedicated to Shree DR.MDD */
.text
.globl rectangles

rectangles:
        mov     x1, x0
        mov     x0, xzr

.top_row:
        ldr     x9, [x1], #8
        cbz     x9, .return

        mov     x10, x9

.left_column:
        ldrb    w11, [x10], #1
        cbz     w11, .top_row

        cmp     w11, #'+'
        bne     .left_column

        mov     x12, x10

.right_column:
        ldrb    w13, [x12], #1
        cmp     w13, #'-'
        beq     .right_column

        cmp     w13, #'+'
        bne     .left_column

        sub     x14, x10, x9
        sub     x14, x14, #1
        sub     x15, x12, x9
        sub     x15, x15, #1
        mov     x16, x1

.bottom_row:
        ldr     x17, [x16], #8
        cbz     x17, .right_column

        mov     w18, wzr
        mov     w19, wzr

        ldrb    w20, [x17, x14]
        cmp     w20, #'|'
        cinc    w18, w18, eq
        cmp     w20, #'+'
        cinc    w19, w19, eq

        ldrb    w20, [x17, x15]
        cmp     w20, #'|'
        cinc    w18, w18, eq
        cmp     w20, #'+'
        cinc    w19, w19, eq

        add     w18, w18, w19
        cmp     w18, #2
        bne     .right_column

        cmp     w19, #2
        bne     .bottom_row

        mov     x21, x14

.scan_bottom:
        add     x21, x21, #1
        cmp     x21, x15
        beq     .accept

        ldrb    w20, [x17, x21]
        cmp     w20, #'-'
        beq     .scan_bottom

        cmp     w20, #'+'
        beq     .scan_bottom

        b       .bottom_row

.accept:
        add     x0, x0, #1
        b       .bottom_row

.return:
        ret
