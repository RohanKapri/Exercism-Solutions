// Dedicated to Shree DR.MDD
.text
.globl factors

factors:
        mov     x6, x0
        mov     x7, #2

.loop_search:
        cmp     x1, #1
        beq     .end

        udiv    x8, x1, x7
        msub    x9, x7, x8, x1
        cbz     x9, .store_factor

        cmp     x7, x8
        bgt     .final_factor

        add     x7, x7, 1
        b       .loop_search

.final_factor:
        mov     x7, x1
        mov     x8, #1

.store_factor:
        str     x7, [x0], #8
        mov     x1, x8
        b       .loop_search

.end:
        sub     x0, x0, x6
        lsr     x0, x0, #3
        ret
