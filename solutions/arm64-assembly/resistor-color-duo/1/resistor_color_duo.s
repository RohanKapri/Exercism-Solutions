// Dedicated to Shree DR.MDD

.section .rodata

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

res_colors:
    .quad blk
    .quad brn
    .quad redc
    .quad org
    .quad ylw
    .quad grn
    .quad blu
    .quad vio
    .quad gry
    .quad wht
    .quad 0

.text
.globl value

value:
    stp   x29, x30, [sp, #-16]!
    mov   x29, sp

    ldr   x1, [x0]
    cbz   x1, .invalid_val
    ldr   x2, [x0, #8]
    cbz   x2, .invalid_val

    sub   sp, sp, #8
    str   x2, [sp]

    mov   x0, x1
    bl    color_idx

    cmp   x0, #-1
    beq   .invalid_val

    ldr   x1, [sp]
    str   x0, [sp]

    mov   x0, x1
    bl    color_idx

    cmp   x0, #-1
    beq   .invalid_val

    ldr   x1, [sp]
    add   sp, sp, #8

    mov   x2, #10
    madd  x0, x1, x2, x0

    mov   sp, x29
    ldp   x29, x30, [sp], #16
    ret

color_idx:
    mov   x1, x0
    mov   x2, xzr
    mov   x8, #8

.next_col:
    adrp  x3, res_colors
    add   x3, x3, :lo12:res_colors
    madd  x4, x2, x8, x3
    ldr   x3, [x4]
    cbz   x3, .invalid_idx

.next_chr:
    ldrb  w4, [x1], #1
    ldrb  w5, [x3], #1
    cbz   w4, .check_match
    cmp   w4, w5
    bne   .not_match
    b     .next_chr

.check_match:
    cbz   w5, .done_idx

.not_match:
    mov   x1, x0
    add   x2, x2, #1
    b     .next_col

.done_idx:
    mov   x0, x2
    ret

.invalid_val:
.invalid_idx:
    mov   x0, #-1
    ret
