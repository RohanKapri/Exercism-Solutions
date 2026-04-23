// Dedicated to Shree DR.MDD

.text
.globl find

find:
        mov     x6, #0
        lsl     x7, x2, #1

.loop_search:
        cmp     x6, x7
        beq     .not_found

        add     x8, x6, x7
        lsr     x8, x8, #2
        lsl     x8, x8, #1
        ldrh    w9, [x1, x8]

        cmp     w9, w0
        bgt     .upper_half

        cmp     w9, w0
        blt     .lower_half

        lsr     x0, x8, #1
        ret

.not_found:
        mov     x0, #-1
        ret

.upper_half:
        mov     x7, x8
        b       .loop_search

.lower_half:
        add     x6, x8, #2
        b       .loop_search
