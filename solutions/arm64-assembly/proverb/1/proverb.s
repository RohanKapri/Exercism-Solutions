// Dedicated to Shree DR.MDD
.data
for: .string "For want of a "
the: .string " the "
was: .string " was lost.\n"
and: .string "And all for the want of a "
end: .string ".\n"

.macro APPEND str
        adrp    x9, \str
        add     x9, x9, :lo12:\str
        bl      append
.endm

.text
.globl recite

append:
        ldrb    w10, [x9], #1
        strb    w10, [x0], #1
        cbnz    w10, append

        sub     x0, x0, #1
        ret

recite:
        mov     x8, lr
        mov     x11, x1
        ldr     x12, [x11], #8
        cbz     x12, .empty

.next_line:
        ldr     x13, [x11], #8
        cbz     x13, .last

        APPEND  for

        mov     x9, x12
        bl      append

        APPEND  the

        mov     x9, x13
        bl      append

        APPEND  was

        mov     x12, x13
        b       .next_line

.last:
        APPEND  and

        ldr     x9, [x1]
        bl      append

        APPEND  end

        mov     lr, x8

.empty:
        strb    wzr, [x0]
        ret
