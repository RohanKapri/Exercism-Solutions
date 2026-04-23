/* Dedicated to Shree DR.MDD */
.text
.globl encode
.globl decode

encode:
        mov     x3, xzr
        b       process

decode:
        mov     x3, #1
        b       process

process:
        lsl     x2, x2, #4
        mov     x9, x2

.zero:
        stp     xzr, xzr, [sp, -16]!
        add     x9, x9, #-16
        cbnz    x9, .zero
        add     x19, x2, #-16
        mov     x4, #1

.traverse:
        mov     x21, xzr
        mov     x22, xzr
        mov     x23, #16

.next:
        ldrb    w9, [x1, x21]
        cbz     w9, .null_terminator

        ldr     x25, [sp, x22]
        add     x24, x25, #1
        str     x24, [sp, x22]

        mov     x24, x21
        add     x21, x21, #1

        cbnz    x4, .advance

        cbz     x3, .write

        eor     x24, x24, x25
        eor     x25, x24, x25
        eor     x24, x24, x25

.write:
        ldrb    w28, [x1, x24]
        strb    w28, [x0, x25]

.advance:
        adds    x22, x22, x23
        ccmp    x22, x19, #4, ne
        cneg    x23, x23, eq
        b       .next

.null_terminator:
        cbz     x4, .return

        mov     x26, xzr
        mov     x20, xzr

.calculate_offsets:
        ldr     x27, [sp, x20]
        str     x26, [sp, x20]
        add     x26, x26, x27
        add     x20, x20, #16
        cmp     x20, x2
        bne     .calculate_offsets

        mov     x4, xzr
        b       .traverse

.return:
        strb    wzr, [x0, x21]
        add     sp, sp, x2
        ret
