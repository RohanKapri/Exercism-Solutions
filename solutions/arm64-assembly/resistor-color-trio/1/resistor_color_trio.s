// Dedicated to Shree DR.MDD

.data
blk:       .string "black"
brn:       .string "brown"
rd:        .string "red"
orgn:      .string "orange"
ylw:       .string "yellow"
grn:       .string "green"
blu:       .string "blue"
vio:       .string "violet"
gry:       .string "grey"
wht:       .string "white"

ohm:       .string " ohms"
kohm:      .string " kiloohms"
Mohm:      .string " megaohms"
Gohm:      .string " gigaohms"

color_list:
        .dword blk
        .dword brn
        .dword rd
        .dword orgn
        .dword ylw
        .dword grn
        .dword blu
        .dword vio
        .dword gry
        .dword wht
        .dword 0

unit_list:
        .dword ohm
        .dword kohm
        .dword Mohm
        .dword Gohm
        .dword 0

.text
.globl color_code
.globl label

color_code:
        adrp    x1, color_list
        add     x1, x1, :lo12:color_list
        mov     x2, x1

.next_color:
        mov     x3, x0
        ldr     x4, [x2], #8

.compare_bytes:
        ldrb    w5, [x3], #1
        ldrb    w6, [x4], #1
        cmp     w5, w6
        bne     .next_color
        cbnz    w5, .compare_bytes

        sub     x2, x2, #8
        sub     x0, x2, x1
        lsr     x0, x0, #3
        ret

label:
        mov     x10, x0
        mov     x11, x1
        mov     x12, lr
        mov     x13, #10

        ldr     x0, [x11], #8
        bl      color_code
        mov     w14, w0

        ldr     x0, [x11], #8
        bl      color_code
        mov     w15, w0

        ldr     x0, [x11]
        bl      color_code
        add     w0, w0, #1
        mov     w16, #3
        udiv    w17, w0, w16
        msub    w18, w17, w16, w0

        cbz     w18, .div_exact

        cbz     w14, .skip_first_digit
        add     w14, w14, #'0'
        strb    w14, [x10], #1

.skip_first_digit:
        add     w15, w15, #'0'
        strb    w15, [x10], #1
        cmp     w18, #1
        beq     .append_units
        mov     w15, #'0'
        strb    w15, [x10], #1
        b .append_units

.div_exact:
        add     w14, w14, #'0'
        strb    w14, [x10], #1
        cbz     w15, .append_units
        mov     w14, #'.'
        strb    w14, [x10], #1
        add     w15, w15, #'0'
        strb    w15, [x10], #1

.append_units:
        adrp    x1, unit_list
        add     x1, x1, :lo12:unit_list
        lsl     w17, w17, #3
        ldr     x2, [x1, x17]

.copy_units:
        ldrb    w3, [x2], #1
        strb    w3, [x10], #1
        cbnz    w3, .copy_units

        mov     lr, x12
        ret
