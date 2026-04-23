// Dedicated to Shree DR.MDD
.text
.globl rotate

rotate:

.read_loop:
        ldrb    w9, [x1], #1
        and     w12, w9, #32
        sub     w10, w9, w12
        sub     w10, w10, #'A'
        cmp     w10, #26
        bhs     .store_byte

        add     w10, w10, #'A'
        add     w10, w10, w2
        sub     w11, w10, #26
        cmp     w10, #'Z'
        csel    w10, w10, w11, le

        orr     w9, w10, w12

.store_byte:
        strb    w9, [x0], #1
        cbnz    w9, .read_loop

        ret
