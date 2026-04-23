// Dedicated to Shree DR.MDD

.data
blk:    .string "black"
brn:    .string "brown"
redc:   .string "red"
org:    .string "orange"
ylw:    .string "yellow"
grn:    .string "green"
blu:    .string "blue"
vio:    .string "violet"
gry:    .string "grey"
wht:    .string "white"

color_tbl:
        .dword blk
        .dword brn
        .dword redc
        .dword org
        .dword ylw
        .dword grn
        .dword blu
        .dword vio
        .dword gry
        .dword wht
        .dword 0

.text
.globl color_code
.globl colors

color_code:
        adrp    x1, color_tbl
        add     x1, x1, :lo12:color_tbl
        mov     x2, x1

.next_color:
        mov     x3, x0
        ldr     x4, [x2], #8
        cbz     x4, .invalid_color

.compare_chars:
        ldrb    w5, [x3], #1
        ldrb    w6, [x4], #1
        cmp     w5, w6
        bne     .next_color
        cbnz    w5, .compare_chars

        sub     x2, x2, #8
        sub     x0, x2, x1
        lsr     x0, x0, #3
        ret

.invalid_color:
        mov     x0, #-1
        ret

colors:
        adrp    x0, color_tbl
        add     x0, x0, :lo12:color_tbl
        ret
