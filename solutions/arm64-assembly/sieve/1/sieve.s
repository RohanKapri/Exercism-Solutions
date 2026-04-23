.text
.globl sieve

sieve:
        add     x2, x1, #16
        and     x2, x2, #-16
        mov     x3, sp
        sub     sp, sp, x2
        mov     x4, #-1
        mov     x5, sp

.fill:
        stp     x4, x4, [x3, #-16]!
        cmp     x3, x5
        bne     .fill

        mov     x3, x0
        mov     x4, #1

.search:
        add     x4, x4, #1
        cmp     x1, x4
        blo     .exit

        ldrb    w5, [sp, x4]
        cbz     w5, .search

        str     x4, [x3], #8
        mul     x5, x4, x4

.mark:
        cmp     x1, x5
        blo     .search

        strb    wzr, [sp, x5]
        add     x5, x5, x4
        b       .mark

.exit:
        sub     x0, x3, x0
        lsr     x0, x0, #3
        add     sp, sp, x2
        ret
