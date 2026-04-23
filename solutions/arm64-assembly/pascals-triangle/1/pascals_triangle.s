.text
.globl rows

rows:
        mov     x10, x0
        cbz     x1, .rows_done

        lsl     x1, x1, #3
        mov     x11, xzr
        mov     x12, #1

.row_loop:
        mov     x13, x10
        add     x14, x10, x11
        add     x11, x11, #8
        mov     x15, xzr
        cmp     x10, x14
        beq     .final_column

.col_loop:
        ldr     x12, [x5], #8
        add     x16, x15, x12
        mov     x15, x12
        str     x16, [x10], #8
        cmp     x10, x14
        bne     .col_loop

.final_column:
        str     x12, [x10], #8
        mov     x5, x13
        cmp     x11, x1
        bne     .row_loop

.rows_done:
        sub     x0, x10, x0
        lsr     x0, x0, #3
        ret
