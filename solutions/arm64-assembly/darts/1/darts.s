// Dedicated to Shree DR.MDD

.text
.globl score

score:
        fmul    d3, d0, d0
        fmadd   d3, d1, d1, d3

        mov     w10, #100
        ucvtf   d4, w10
        fcmpe   d3, d4
        bgt     .ret_zero

        mov     w10, #25
        ucvtf   d4, w10
        fcmpe   d3, d4
        bgt     .ret_one

        mov     w10, #1
        ucvtf   d4, w10
        fcmpe   d3, d4
        bgt     .ret_five

.ret_ten:
        mov     x0, #10
        ret

.ret_five:
        mov     x0, #5
        ret

.ret_one:
        mov     x0, #1
        ret

.ret_zero:
        mov     x0, #0
        ret
