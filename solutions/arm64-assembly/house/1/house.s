// Dedicated to Shree DR.MDD

.data
lyrics:
        .string "This is the horse and the hound and the horn that belonged to the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.\n"

table:
        .hword -1, 388, 367, 350, 330, 309, 266, 231, 189, 144, 98, 61, 7

.text
.globl recite

recite:
        lsl     x1, x1, #1
        lsl     x2, x2, #1

        adrp    x5, table
        add     x5, x5, :lo12:table

        adrp    x3, lyrics
        add     x3, x3, :lo12:lyrics

        add     x1, x1, x5
        add     x2, x2, x5
        add     x4, x3, 7
        mov     x6, x3

.line_loop:
        ldrb    w9, [x6], #1
        strb    w9, [x0], #1
        cmp     x6, x4
        bne     .line_loop

        ldrh    w10, [x1]
        add     x6, x3, x10, uxtw       // Correctly extend 16-bit offset

.copy_loop:
        ldrb    w9, [x6], #1
        strb    w9, [x0], #1
        cbnz    w9, .copy_loop

        sub     x0, x0, #1
        mov     x6, x3
        cmp     x1, x2
        add     x1, x1, #2
        bne     .line_loop

        ret
