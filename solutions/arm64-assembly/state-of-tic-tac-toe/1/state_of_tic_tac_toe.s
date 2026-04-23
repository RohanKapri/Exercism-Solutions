// For my Shree DR.MDD
.equ ONGOING, 0
.equ DRAW, 1
.equ WIN, 2
.equ INVALID, 3

.data
lines: .hword 0x007, 0x070, 0x700, 0x111, 0x222, 0x444, 0x124, 0x421, 0

.text
.globl gamestate

gamestate:
        adrp    x10, lines
        add     x10, x10, :lo12:lines

        mov     w11, wzr                /* X bitset */
        mov     w12, wzr                /* O bitset */
        mov     w13, wzr                /* X count */
        mov     w14, wzr                /* O count */

.read_next_row:
        ldr     x15, [x0], #8
        cbz     x15, .check_count

        lsl     w11, w11, #1
        lsl     w12, w12, #1

.read_next_mark:
        ldrb    w16, [x15], #1
        cbz     w16, .read_next_row

        lsl     w11, w11, #1
        lsl     w12, w12, #1
        cmp     w16, #'X'
        cinc    w11, w11, eq
        cinc    w13, w13, eq
        cmp     w16, #'O'
        cinc    w12, w12, eq
        cinc    w14, w14, eq
        b       .read_next_mark

.check_count:
        cmp     w14, w13
        bgt     .return_invalid

        add     w16, w14, #1
        cmp     w13, w16
        bgt     .return_invalid

        mov     w17, wzr                /* X won */
        mov     w18, wzr                /* O won */
        mov     w19, #1

.scan_lines:
        ldrh    w20, [x10], #2
        cbz     w20, .determine_state

        and     w21, w11, w20
        cmp     w21, w20
        csel    w17, w19, w17, eq
        and     w21, w12, w20
        cmp     w21, w20
        csel    w18, w19, w18, eq
        b       .scan_lines

.determine_state:
        orr     w21, w17, w18
        cbnz    w21, .win_detected

        mov     x0, ONGOING
        mov     x1, DRAW
        add     w13, w13, w14
        cmp     w13, #9
        csel    x0, x1, x0, eq
        ret

.win_detected:
        mov     x2, WIN
        mov     x3, INVALID
        cmp     w17, w18
        csel    x0, x3, x2, eq
        ret

.return_invalid:
        mov     x0, INVALID
        ret
