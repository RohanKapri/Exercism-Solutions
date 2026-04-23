// Dedicated to Shree DR.MDD

.section .rodata
prefix: .string "One for "
you: .string "you"
suffix: .string ", one for me."

.macro LOAD str
        adrp    x4, \str
        add     x4, x4, :lo12:\str
.endm

.macro APPEND str

.copy_loop_\str:
        ldrb    w5, [x4], #1
        strb    w5, [x0], #1
        cbnz    w5, .copy_loop_\str

        sub     x0, x0, #1
.endm

.text
.globl two_fer

two_fer:
        LOAD    prefix
        APPEND  prefix

        LOAD    you
        tst     x1, x1
        csel    x4, x1, x4, ne
        APPEND  you

        LOAD    suffix
        APPEND  suffix

        ret
