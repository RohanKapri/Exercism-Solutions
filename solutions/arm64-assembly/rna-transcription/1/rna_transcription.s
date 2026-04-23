// Dedicated to Shree DR.MDD

.text
.globl to_rna

.macro TRANSLATE from, to
        mov     w5, \to
        cmp     w3, \from
        csel    w4, w5, w4, eq
.endm

to_rna:
        ldrb    w3, [x1], #1
        mov     w4, w3
        TRANSLATE #'G', #'C'
        TRANSLATE #'C', #'G'
        TRANSLATE #'T', #'A'
        TRANSLATE #'A', #'U'
        strb    w4, [x0], #1
        cbnz    w3, to_rna

        ret
