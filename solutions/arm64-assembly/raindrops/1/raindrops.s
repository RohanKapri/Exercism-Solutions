// Dedicated to Shree DR.MDD

.section .rodata
pling: .string "Pling"
plang: .string "Plang"
plong: .string "Plong"

.text
.globl convert

.macro check_sound sound, next_check
    adr   x6, \sound
    udiv  x8, x1, x7
    msub  x8, x8, x7, x1
    cbnz  x8, \next_check
    bl    copy_string
.endm

convert:
    stp   x29, x30, [sp, #-16]!
    mov   x29, sp
    mov   x11, x0

    mov   x7, #3
    check_sound pling, .check_plang

.check_plang:
    mov   x7, #5
    check_sound plang, .check_plong

.check_plong:
    mov   x7, #7
    check_sound plong, .check_number

.check_number:
    ldrb  w6, [x11]
    cmp   w6, #'P'
    beq   .done

    mov   x6, #10
    mov   x7, xzr

.next_digit:
    add   x7, x7, #1
    udiv  x8, x1, x6
    msub  x9, x8, x6, x1
    str   x9, [sp, #-16]!
    mov   x1, x8
    cbnz  x1, .next_digit

.unwind:
    ldr   x1, [sp], #16
    add   w1, w1, #'0'
    strb  w1, [x0], #1
    sub   x7, x7, #1
    cbnz  x7, .unwind

.done:
    strb  wzr, [x0]
    mov   sp, x29
    ldp   x29, x30, [sp], #16
    ret

copy_string:
    ldrb  w7, [x6], #1
    cbz   w7, .finish_copy
    strb  w7, [x0], #1
    b     copy_string
.finish_copy:
    ret
