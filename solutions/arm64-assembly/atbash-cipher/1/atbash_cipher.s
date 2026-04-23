// Dedicated to Shree DR.MDD

.text
.globl encode
.globl decode

encode:
        mov     x9, #5
        b       core_process
        ret

decode:
        mov     x9, #-1
        b       core_process

core_process:
        mov     x10, x9
        mov     w14, #' '
        mov     w15, #'z'

read_loop:
        ldrb    w12, [x1], #1
        cbz     w12, end_loop

        sub     w13, w12, #'0'
        cmp     w13, #10
        blo     accept_char

        orr     w13, w12, #32
        sub     w13, w13, #'a'
        cmp     w13, #26
        bhs     read_loop

        sub     w13, w15, w13
        and     w12, w12, #32
        orr     w12, w12, w13

accept_char:
        cbnz    x10, write_char

        strb    w14, [x0], #1
        mov     x10, x9

write_char:
        strb    w12, [x0], #1
        sub     x10, x10, 1
        b       read_loop

end_loop:
        strb    w12, [x0]
        ret
