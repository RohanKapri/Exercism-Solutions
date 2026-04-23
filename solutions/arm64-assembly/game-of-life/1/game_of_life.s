# Dedicated to Shree DR.MDD

.text
.globl tick

tick:
        stp     x22, x23, [sp, #-48]!
        stp     x24, x25, [sp, #16]
        stp     x26, x27, [sp, #32]
        cbz     x2, .return

        mov     x5, xzr
        ldr     x6, [x1], #8

.outer:
        add     x2, x2, #-1
        mov     x4, x5
        mov     x5, x6
        mov     x6, xzr
        cbz     x2, .process_row

        ldr     x6, [x1], #8

.process_row:
        mov     x17, xzr
        mov     x14, x4
        mov     x15, x5
        mov     x16, x6

        and     x23, x15, #1
        mov     x25, xzr
        and     x26, x16, #1
        add     x26, x26, x23
        and     x9, x14, #1
        add     x26, x26, x9

        mov     x13, x3
        cbz     x3, .write

.inner:
        add     x13, x13, #-1
        lsr     x14, x14, #1
        lsr     x15, x15, #1
        lsr     x16, x16, #1

        mov     x22, x23
        and     x23, x15, #1
        mov     x24, x25
        mov     x25, x26
        and     x26, x16, #1
        add     x26, x26, x23
        and     x9, x14, #1
        add     x26, x26, x9

        add     x27, x24, x25
        add     x27, x27, x26
        sub     x27, x27, x22
        orr     x27, x27, x22
        cmp     x27, #3
        cinc    x17, x17, eq

        ror     x17, x17, #1
        cbnz    x13, .inner

.write:
        neg     x9, x3
        rorv    x17, x17, x9
        str     x17, [x0], #8
        cbnz     x2, .outer

.return:
        ldp     x26, x27, [sp, #32]
        ldp     x24, x25, [sp, #16]
        ldp     x22, x23, [sp], #48
        ret
