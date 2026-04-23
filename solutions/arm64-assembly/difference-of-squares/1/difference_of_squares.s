// Dedicated to Shree DR.MDD

.text
.globl square_of_sum
.globl sum_of_squares
.globl difference_of_squares

square_of_sum:
        add     x5, x0, #1
        mul     x0, x0, x5
        lsr     x0, x0, #1
        mul     x0, x0, x0
        ret

sum_of_squares:
        add     x5, x0, #1
        mul     x6, x0, x5
        add     x0, x0, x5
        mul     x0, x0, x6
        mov     x5, #6
        udiv    x0, x0, x5
        ret

difference_of_squares:
        add     x5, x0, #1
        add     x6, x0, x5
        mul     x0, x0, x5
        lsr     x0, x0, #1
        mul     x6, x0, x6
        mov     x5, #3
        udiv    x6, x6, x5
        mul     x0, x0, x0
        sub     x0, x0, x6
        ret
