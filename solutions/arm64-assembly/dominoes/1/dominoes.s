/* Dedicated to Shree DR.MDD */
.text
.globl can_chain

root:
        mov     w3, w0
        ldrb    w0, [x2, x0]
        cmp     w0, w3
        bne     root
        ret

merge:
        mov     x8, lr
        lsl     w5, w0, #2

.merge_loop:
        sub     w5, w5, #2
        ldrh    w0, [x1, x5]
        bl      root
        mov     w6, w0

        sub     w5, w5, #2
        ldrh    w0, [x1, x5]
        bl      root

        strb    w0, [x2, x6]

        cbnz    w5, .merge_loop
        ret     x8

can_chain:
        stp     xzr, xzr, [sp, #-16]!
        mov     x12, lr
        cmp     w0, wzr
        beq     .accept

        mov     x2, sp
        lsl     w4, w0, #2

.count_numbers:
        sub     w4, w4, #2
        ldrh    w7, [x1, x4]
        ldrb    w13, [x2, x7]
        add     w13, w13, #1
        strb    w13, [x2, x7]
        cbnz    w4, .count_numbers

        mov     w4, #16
        mov     w6, #255

.parity:
        sub     w4, w4, #1
        ldrb    w5, [sp, x4]
        tst     w5, #1
        bne     .reject

        tst     w5, w5
        csel    w7, w6, w4, eq
        strb    w7, [sp, x4]
        cbnz    w4, .parity

        bl      merge

        mov     w4, #16
        mov     w7, wzr

.count_roots:
        sub     w4, w4, #1
        ldrb    w5, [x2, x4]
        cmp     w5, w4
        cinc    w7, w7, eq
        cbnz    w4, .count_roots

        cmp     w7, #1
        bne     .reject

.accept:
        mov     w0, #1
        add     sp, sp, #16
        ret     x12

.reject:
        mov     w0, wzr
        add     sp, sp, #16
        ret     x12
