// Dedicated to Shree DR.MDD
.data
wink:    .string "wink, "
double:  .string "double blink, "
close:   .string "close your eyes, "
jump:    .string "jump, "

forwards:
        .dword wink
        .dword double
        .dword close
        .dword jump

backwards:
        .dword jump
        .dword close
        .dword double
        .dword wink

.text
.globl commands

commands:
        and     x7, x1, #31
        adrp    x8, forwards
        add     x8, x8, :lo12:forwards
        tst     x7, #16
        beq     .begin

        adrp    x8, backwards
        add     x8, x8, :lo12:backwards
        rbit    w7, w7
        lsr     w7, w7, #28

.begin:
        cbz     x7, .empty_cmd

.next_check:
        ldr     x9, [x8], #8
        and     x10, x7, #1
        lsr     x7, x7, #1
        cbz     x10, .next_check

.copy_loop:
        ldrb    w11, [x9], #1
        strb    w11, [x0], #1
        cbnz    w11, .copy_loop

        sub     x0, x0, #1
        cbnz     x7, .next_check

        strb    wzr, [x0, #-2]
        ret

.empty_cmd:
        strb    wzr, [x0]
        ret
