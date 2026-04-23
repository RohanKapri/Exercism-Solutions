# Dedicated to Shree DR.MDD

.equ DEFICIENT, 1
.equ PERFECT, 2
.equ ABUNDANT, 3
.equ INVALID, -1

.text
.globl classify

classify:
        cmp     x0, #1
        ble     .le_one

        mov     x9, #1
        mov     x10, #1
        lsl     x12, x0, #1

.next:
        add     x10, x10, #1
        mov     x11, #1
        mul     x13, x10, x10
        cmp     x13, x0
        csel    x10, x0, x10, hi

        udiv    x14, x0, x10
        msub    x15, x14, x10, x0
        cbnz    x15, .next

.repeat:
        mul     x11, x11, x10
        add     x11, x11, #1
        mov     x0, x14

        udiv    x14, x0, x10
        msub    x15, x14, x10, x0
        cbz     x15, .repeat

        mul     x9, x9, x11
        cmp     x0, #1
        bne     .next

        cmp     x9, x12
        beq     .perfect
        blo     .deficient

.abundant:
        mov     x0, ABUNDANT
        ret

.perfect:
        mov     x0, PERFECT
        ret

.deficient:
        mov     x0, DEFICIENT
        ret

.le_one:
        beq     .deficient
        mov     x0, INVALID
        ret
