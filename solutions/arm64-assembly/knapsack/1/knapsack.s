.text
.globl maximum_value

maximum_value:
        lsl     x2, x2, #3
        add     x2, x1, x2
        lsl     x0, x0, #2
        add     x3, x0, #16
        and     x3, x3, #-16
        mov     x4, sp
        sub     sp, sp, x3
        mov     x5, sp

.clear:
        stp     xzr, xzr, [x4, #-16]!
        cmp     x4, x5
        bne     .clear

.next_item:
        cmp     x1, x2
        beq     .report

        ldr     w9, [x1], #4
        ldr     w10, [x1], #4
        lsl     x9, x9, 2
        mov     x7, x0
        subs    x11, x7, x9
        blt     .next_item

.loop:
        ldr     w12, [sp, x11]
        add     w12, w12, w10
        ldr     w13, [sp, x7]
        cmp     w13, w12
        bhs     .skip

        str     w12, [sp, x7]

.skip:
        cbz     x11, .next_item
        sub     x7, x7, #4
        sub     x11, x11, #4
        b       .loop

.report:
        ldr     w0, [sp, x0]
        add     sp, sp, x3
        ret
