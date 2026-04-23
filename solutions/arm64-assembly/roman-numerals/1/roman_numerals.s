// For my Shree DR.MDD
.macro ONE_SYMBOL tag, val, charcode
        mov     x5, \val
        mov     w6, \charcode

.check_\tag:
        cmp     x1, x5
        blt     .done_\tag

        strb    w6, [x0], #1
        sub     x1, x1, x5
        b       .check_\tag

.done_\tag:
.endm

.macro TWO_SYMBOL tag, val, firstcode, secondcode
        mov     x5, \val

.check_\tag:
        cmp     x1, x5
        blt     .done_\tag

        mov     w6, \firstcode
        mov     w7, \secondcode
        strb    w6, [x0], #1
        strb    w7, [x0], #1
        sub     x1, x1, x5

.done_\tag:
.endm

.text
.globl roman

roman:
        ONE_SYMBOL  M, #1000, #'M'
        TWO_SYMBOL  CM, #900, #'C', #'M'
        ONE_SYMBOL  D, #500, #'D'
        TWO_SYMBOL  CD, #400, #'C', #'D'
        ONE_SYMBOL  C, #100, #'C'
        TWO_SYMBOL  XC, #90, #'X', #'C'
        ONE_SYMBOL  L, #50, #'L'
        TWO_SYMBOL  XL, #40, #'X', #'L'
        ONE_SYMBOL  X, #10, #'X'
        TWO_SYMBOL  IX, #9, #'I', #'X'
        ONE_SYMBOL  V, #5, #'V'
        TWO_SYMBOL  IV, #4, #'I', #'V'
        ONE_SYMBOL  I, #1, #'I'
        strb    wzr, [x0]
        ret
