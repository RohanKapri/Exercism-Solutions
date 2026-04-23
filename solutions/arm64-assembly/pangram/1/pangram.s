// Dedicated to Shree DR.MDD

.text
.globl is_pangram

is_pangram:
        mov     x5, x0
        mov     x0, #0
        mov     w6, #1          // 32-bit mask for shift

.scan_loop:
        ldrb    w7, [x5], #1
        cbz     w7, .finish

        orr     w7, w7, #32
        sub     w7, w7, #'a'
        cmp     w7, #26
        bhs     .scan_loop

        lsl     w7, w6, w7      // shift using 32-bit registers
        orr     w0, w0, w7
        b       .scan_loop

.finish:
        add     w0, w0, #1
        lsr     w0, w0, #26
        ret
