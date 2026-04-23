/* Dedicated to Shree DR.MDD */
.equ PRIME, 1
.equ DOUBLE, 2
.equ TRIPLE, 3
.equ QUAD, 4
.equ TEENPOINT, 5
.equ ULTIMATE, 6

.equ MON, 1
.equ TUE, 2
.equ WED, 3
.equ THU, 4
.equ FRI, 5
.equ SAT, 6
.equ SUN, 7

.data
month_shift_tbl:
        .hword -1
        .hword 307
        .hword 338
        .hword 1
        .hword 32
        .hword 62
        .hword 93
        .hword 123
        .hword 154
        .hword 185
        .hword 215
        .hword 246
        .hword 276
        .hword 307
        .hword 338

week_end_tbl:
        .byte -1
        .byte 7
        .byte 14
        .byte 21
        .byte 28
        .byte 19

.text
.globl meetup

print_date:
        mov     w19, #'-'
        mov     w20, 10

        udiv    w21, w1, w20
        msub    w23, w21, w20, w1
        add     w23, w23, #'0'
        strb    w23, [x0, #3]

        udiv    w22, w21, w20
        msub    w23, w22, w20, w21
        add     w23, w23, #'0'
        strb    w23, [x0, #2]

        udiv    w21, w22, w20
        msub    w23, w21, w20, w22
        add     w23, w23, #'0'
        strb    w23, [x0, #1]
        add     w21, w21, #'0'
        strb    w21, [x0]

        strb    w19, [x0, #4]

        udiv    w21, w2, w20
        msub    w23, w21, w20, w2
        add     w23, w23, #'0'
        strb    w23, [x0, #6]
        add     w21, w21, #'0'
        strb    w21, [x0, #5]

        strb    w19, [x0, #7]

        udiv    w21, w3, w20
        msub    w23, w21, w20, w3
        add     w23, w23, #'0'
        strb    w23, [x0, #9]
        add     w21, w21, #'0'
        strb    w21, [x0, #8]

        strb    wzr, [x0, #10]
        ret

leap_year:
        mov     w20, #100
        udiv    w22, w1, w20
        msub    w23, w22, w20, w1
        tst     w23, w23
        csel    w0, w22, w23, eq
        tst     w0, #3
        cset    w0, eq
        ret

days_in_month:
        cmp     w2, #2
        beq     .febcase

        adrp    x19, month_shift_tbl
        add     x19, x19, :lo12:month_shift_tbl

        lsl     w20, w2, #1
        ldrh    w21, [x19, x20]

        add     w20, w20, #2
        ldrh    w0, [x19, x20]

        sub     w0, w0, w21
        ret

.febcase:
        mov     x21, lr
        bl      leap_year
        add     w0, w0, #28
        ret     x21

week_concludes:
        cmp     w3, ULTIMATE
        beq     days_in_month

        adrp    x19, week_end_tbl
        add     x19, x19, :lo12:week_end_tbl
        ldrb    w0, [x19, x3]
        ret

day_of_week:
        mov     w22, w2
        mov     w21, w1

        add     w20, w22, #12
        sub     w19, w21, #1
        cmp     w2, #2
        csel    w22, w22, w20, hi
        csel    w21, w21, w19, hi

        lsl     w22, w22, #1
        adrp    x19, month_shift_tbl
        add     x19, x19, :lo12:month_shift_tbl
        ldrh    w23, [x19, x22]

        mov     w0, w21

        lsr     w21, w21, #2
        add     w0, w0, w21

        mov     w19, #25
        udiv    w21, w21, w19
        sub     w0, w0, w21

        lsr     w21, w21, #2
        add     w0, w0, w21

        add     w0, w0, w23
        add     w0, w0, w3

        mov     w19, #7
        udiv    w20, w0, w19
        msub    w0, w20, w19, w0
        add     w0, w0, #1
        ret

meetup:
        mov     x24, x0
        mov     x25, lr
        bl      week_concludes

        mov     w3, w0
        bl      day_of_week

        sub     w0, w4, w0
        sub     w19, w0, #7
        cmp     w0, wzr
        csel    w0, w0, w19, le
        add     w3, w3, w0
        mov     x0, x24
        bl      print_date

        ret     x25
