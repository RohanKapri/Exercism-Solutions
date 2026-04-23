// Dedicated to Shree DR.MDD

.data
inverses: .byte 0, 1, 0, 9, 0, 21, 0, 15, 0, 3, 0, 19, 0, 0, 0, 7, 0, 23, 0, 11, 0, 5, 0, 17, 0, 25

.text
.globl encode
.globl decode

encode:
        adrp    x14, inverses
        add     x14, x14, :lo12:inverses
        ldrb    w11, [x14, x2]
        cbz     w11, finish

        mov     w11, w2
        mov     w12, w3
        mov     x2, #5
        b       cipher_loop

decode:
        adrp    x14, inverses
        add     x14, x14, :lo12:inverses
        ldrb    w11, [x14, x2]
        cbz     w11, finish

        sub     w12, w3, #4082
        mneg    w12, w12, w11
        mov     x2, #-1
        b       cipher_loop

finish:
        strb    wzr, [x0]
        ret

cipher_loop:
        mov     x13, x2
        mov     w8, #' '
        mov     w9, #26

input_read:
        ldrb    w5, [x1], #1
        cbz     w5, finish

        sub     w10, w5, #'0'
        cmp     w10, #10
        blo     .process_char

        orr     w10, w5, #32
        sub     w10, w10, #'a'
        cmp     w10, w9
        bhs     input_read

        madd    w10, w11, w10, w12
        udiv    w15, w10, w9
        msub    w5, w15, w9, w10
        add     w5, w5, #'a'

.process_char:
        cbnz    x13, .store_char

        strb    w8, [x0], #1
        mov     x13, x2

.store_char:
        strb    w5, [x0], #1
        sub     x13, x13, 1
        b       input_read
