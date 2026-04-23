.data
names:  .string "        clover,         grass,                                      radishes,       violets, "

.text
.globl plants

plants:
        adrp    x9, names
        add     x9, x9, :lo12:names

        ldrb    w2, [x2]
        sub     w2, w2, #'A'
        lsl     w2, w2, #1
        add     w3, w2, #1
        mov     x4, x1

.scan:
        ldrb    w5, [x4], #1
        cbnz    w5, .scan

        sub     x4, x4, x1
        lsr     x4, x4, #1
        mov     x7, sp
        stp     w2, w3, [sp, #-16]!
        add     w2, w2, w4
        add     w3, w3, w4
        stp     w2, w3, [sp, #8]
        mov     x6, sp

.next:
        ldr     w2, [x6], #4
        ldrb    w2, [x1, x2]
        sub     w2, w2, #'A'
        lsl     w2, w2, #2
        add     x2, x9, x2

.copy:
        ldrb    w3, [x2], #1
        strb    w3, [x0], #1
        cmp     w3, #' '
        bne     .copy

        cmp     x6, x7
        bne     .next

        strb    wzr, [x0, #-2]
        mov     sp, x7
        ret
