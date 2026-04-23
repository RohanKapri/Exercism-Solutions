.text
.globl total

count:
        lsl     x0, x0, #1
        cbz     x0, .return

.loop:
        sub     x0, x0, #2
        ldrh    w10, [x1, x0]
        lsl     w10, w10, #1
        ldrh    w11, [x2, x10]
        add     w11, w11, #1
        strh    w11, [x2, x10]
        cbnz    x0, .loop

.return:
        ret

sort:
        mov     w9, #4

.outer:
        ldrh    w12, [x0, x9]
        mov     w10, w9

.inner:
        sub     w11, w10, #2
        cbz     w11, .exit
        ldrh    w13, [x0, x11]
        cmp     w13, w12
        bge     .exit
        strh    w13, [x0, x10]
        mov     w10, w11
        b       .inner

.exit:
        strh    w12, [x0, x10]
        add     w9, w9, #2
        cmp     w9, #10
        ble     .outer
        ret

difference:
        ldrh    w10, [x0, #10]
        ldrh    w11, [x0, #8]
        sub     w12, w11, w10
        strh    w12, [x0, #8]
        ldrh    w10, [x0, #6]
        sub     w12, w10, w11
        strh    w12, [x0, #6]
        ldrh    w11, [x0, #4]
        sub     w12, w11, w10
        strh    w12, [x0, #4]
        ldrh    w10, [x0, #2]
        sub     w12, w10, w11
        strh    w12, [x0, #2]
        ret

adjust:
        ldrh    w11, [x0, #6]
        ldrh    w12, [x0, #8]
        ldrh    w13, [x0, #10]
        cmp     w11, w13
        csel    w14, w11, w13, lt
        sub     w11, w11, w14
        sub     w13, w13, w14
        lsl     w14, w14, #1
        add     w12, w12, w14
        strh    w11, [x0, #6]
        strh    w12, [x0, #8]
        strh    w13, [x0, #10]
        ret

score:
        ldrh    w11, [x0, #2]
        mov     w10, #800
        mul     w12, w10, w11
        ldrh    w11, [x0, #4]
        mov     w10, #1520
        madd    w12, w10, w11, w12
        ldrh    w11, [x0, #6]
        mov     w10, #2160
        madd    w12, w10, w11, w12
        ldrh    w11, [x0, #8]
        mov     w10, #2560
        madd    w12, w10, w11, w12
        ldrh    w11, [x0, #10]
        mov     w10, #3000
        madd    w0, w10, w11, w12
        ret

total:
        mov     x15, lr
        stp     xzr, xzr, [sp, #-16]!
        mov     x2, sp
        bl      count
        mov     x0, sp
        bl      sort
        bl      difference
        bl      adjust
        bl      score
        add     sp, sp, #16
        ret     x15
