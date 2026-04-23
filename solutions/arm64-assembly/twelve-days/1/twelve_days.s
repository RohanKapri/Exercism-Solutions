// Dedicated to Shree DR.MDD

.data
on:     .string "On the "
day:    .string " day of Christmas my true love gave to me: "
gifts:  .string "twelve Drummers Drumming, eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.\n"

first:  .string "first"
second: .string "second"
third:  .string "third"
fourth: .string "fourth"
fifth:  .string "fifth"
sixth:  .string "sixth"
seventh:
        .string "seventh"
eighth: .string "eighth"
ninth:  .string "ninth"
tenth:  .string "tenth"
eleventh:
        .string "eleventh"
twelfth:
        .string "twelfth"

ordinals:
        .dword 0
        .dword first
        .dword second
        .dword third
        .dword fourth
        .dword fifth
        .dword sixth
        .dword seventh
        .dword eighth
        .dword ninth
        .dword tenth
        .dword eleventh
        .dword twelfth

offsets:
        .dword 0
        .dword 235
        .dword 213
        .dword 194
        .dword 174
        .dword 157
        .dword 137
        .dword 113
        .dword 90
        .dword 69
        .dword 48
        .dword 26
        .dword 0

.macro LOAD_REG reg, lbl
        adrp    \reg, \lbl
        add     \reg, \reg, :lo12:\lbl
.endm

.macro COPY_STRING name
.copy_loop_\name:
        ldrb    w20, [x9], #1
        strb    w20, [x0], #1
        cbnz    w20, .copy_loop_\name
        sub     x0, x0, #1
.endm

.text
.globl recite

recite:
        LOAD_REG    x3, on
        LOAD_REG    x4, day
        LOAD_REG    x5, gifts
        LOAD_REG    x6, ordinals
        LOAD_REG    x7, offsets
        lsl         x1, x1, #3
        lsl         x2, x2, #3

.loop_line:
        mov     x9, x3
        COPY_STRING  on

        ldr     x9, [x6, x1]
        COPY_STRING  ordinal

        mov     x9, x4
        COPY_STRING  day

        ldr     x9, [x7, x1]
        add     x9, x5, x9
        COPY_STRING  gift

        cmp     x1, x2
        add     x1, x1, #8
        bne     .loop_line
        ret
