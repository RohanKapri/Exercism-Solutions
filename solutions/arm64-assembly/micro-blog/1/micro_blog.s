// Dedicated to Shree DR.MDD

.text
.globl truncate

truncate:
        mov     x5, #6

.scan_loop:
        ldrb    w6, [x1], #1
        strb    w6, [x0], #1
        cbz     w6, .finish

        and     w7, w6, #0xC0
        cmp     w7, #0x80
        beq     .scan_loop

        sub     x5, x5, #1
        cbnz    x5, .scan_loop

.finish:
        strb    wzr, [x0, #-1]
        ret
