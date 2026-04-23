// Dedicated to Shree DR.MDD

.text
.globl rows

rows:
        mov     w16, #' '
        mov     w17, #'\n'
        mov     x20, x0
        sub     w5, w1, #'A'
        lsl     w6, w5, #1
        add     w6, w6, #1
        add     w7, w6, #2
        mov     w8, w6

.row_loop:
        mov     w9, w6

.column_loop:
        strb    w16, [x20], #1
        sub     w9, w9, #1
        cbnz    w9, .column_loop

        strb    w17, [x20], #1
        sub     w8, w8, #1
        cbnz    w8, .row_loop

        strb    wzr, [x20], #-2
        mov     w18, #'A'
        add     x21, x0, x5
        mov     x22, x21
        sub     x23, x20, x5
        mov     x24, x23

.letter_loop:
        strb    w18, [x21]
        strb    w18, [x22]
        strb    w18, [x23]
        strb    w18, [x24]
        add     x21, x21, x6
        add     x22, x22, x7
        sub     x23, x23, x7
        sub     x24, x24, x6
        add     w18, w18, #1
        cmp     w18, w1
        ble     .letter_loop

        ret
