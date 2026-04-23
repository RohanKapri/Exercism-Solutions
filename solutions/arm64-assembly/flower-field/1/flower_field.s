.text
.globl annotate

annotate:
        mov     x2, x1
        ldrb    w3, [x2]
        cbz     w3, .return

        mov     w16, #'*'
        mov     w14, #'\n'

.find_newline:
        ldrb    w3, [x2], #1
        cmp     w3, w14
        bne     .find_newline

        sub     x4, x2, x1
        mov     x2, x1

.find_null:
        add     x2, x2, x4
        ldrb    w3, [x2]
        cbnz    w3, .find_null

        mov     x5, x2
        mov     x7, x1
        mov     x8, x1

.next_row:
        mov     x10, xzr
        mov     x11, xzr
        mov     x6, x7
        mov     x7, x8

        add     x8, x7, x4
        cmp     x8, x5
        bne     .first_column

        mov     x8, x7

.first_column:
        cmp     x4, #1
        beq     .write_newline

.next_column:
        mov     x9, x10
        mov     x10, x11
        add     x11, x10, #2
        cmp     x11, x4
        cset    x11, ne
        add     x11, x10, x11

        ldrb    w3, [x7, x10]
        cmp     w3, w16
        beq     .write_square

        mov     w15, wzr
        sub     x12, x6, x4

.adjacent_row:
        add     x12, x12, x4
        sub     x13, x9, #1

.adjacent_column:
        add     x13, x13, #1
        ldrb    w3, [x12, x13]
        cmp     w3, w16
        cset    x2, eq
        add     w15, w15, w2
        cmp     x13, x11
        bne     .adjacent_column

        cmp     x12, x8
        bne     .adjacent_row

        mov     w3, #' '
        cbz     w15, .write_square

        add     w3, w15, #'0'

.write_square:
        strb    w3, [x0], #1
        cmp     x10, x11
        bne     .next_column

.write_newline:
        strb    w14, [x0], #1
        cmp     x7, x8
        bne     .next_row

.return:
        strb    wzr, [x0]
        ret
