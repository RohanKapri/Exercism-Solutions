.text
.globl prime

prime:
        cmp     x0, #3
        blt     .prime_small

        clz     x7, x0
        mov     x8, #64
        sub     x7, x8, x7
        mul     x7, x0, x7
        lsr     x7, x7, #1
        add     x7, x7, #15
        and     x7, x7, #-16
        mov     x9, sp
        sub     sp, sp, x7
        mov     x10, #-1
        mov     x11, sp

.fill_loop:
        stp     x10, x10, [x9, #-16]!
        cmp     x9, x11
        bne     .fill_loop

        mov     x12, #1
        sub     x0, x0, #1

.search_loop:
        add     x12, x12, #2
        lsr     x13, x12, #1
        ldrb    w14, [sp, x13]
        cbz     w14, .search_loop

        sub     x0, x0, #1
        cbz     x0, .prime_exit

        mul     x15, x12, x12
        lsr     x15, x15, #1

.mark_loop:
        cmp     x15, x7
        bhs     .search_loop

        strb    wzr, [sp, x15]
        add     x15, x15, x12
        b       .mark_loop

.prime_exit:
        mov     x0, x12
        add     sp, sp, x7
        ret

.prime_small:
        add     x0, x0, #1
        ret
