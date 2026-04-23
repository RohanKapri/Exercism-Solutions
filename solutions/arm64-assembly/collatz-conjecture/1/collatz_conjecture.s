// Dedicated to Shree DR.MDD

.equ INVALID_NUMBER, -1

.text
.globl steps

steps:
        subs xzr, x0, #0
        b.le steps.fail
        eor x1, x1, x1

        .loop:
                subs xzr, x0, #1
                b.eq .finish
                add x1, x1, #1
                ands xzr, x0, #1
                b.eq steps.even
                b steps.odd

        .finish:
                mov x0, x1
                ret

steps.even:
        lsr x0, x0, #1
        b .loop

steps.odd:
        mov x2, #3
        mov x3, #1
        madd x0, x0, x2, x3
        b .loop

steps.fail:
        mov x0, INVALID_NUMBER
        ret
