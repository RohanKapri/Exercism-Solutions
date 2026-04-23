// For my Shree DR.MDD
.text
.globl encode
.globl decode

encode:
        lsl     x4, x2, #2              /* size in bytes */
        add     x4, x1, x4              /* end of input */
        mov     x5, x0                  /* output start */

.encode_loop:
        cmp     x1, x4
        beq     .encode_done

        ldr     w6, [x1], #4
        cmp     w6, #127
        bls     .single

        lsr     w7, w6, #7
        cmp     w7, #127
        bls     .double

        lsr     w8, w7, #7
        cmp     w8, #127
        bls     .triple

        lsr     w9, w8, #7
        cmp     w9, #127
        bls     .quad

        lsr     w10, w9, #7
        orr     w10, w10, #128
        strb    w10, [x0], #1

.quad:
        orr     w9, w9, #128
        strb    w9, [x0], #1

.triple:
        orr     w8, w8, #128
        strb    w8, [x0], #1

.double:
        orr     w7, w7, #128
        strb    w7, [x0], #1

.single:
        and     w6, w6, #127
        strb    w6, [x0], #1
        b       .encode_loop

.encode_done:
        sub     x0, x0, x5
        ret

decode:
        add     x4, x1, x2              /* end of input */
        mov     x5, x0                  /* output start */

.decode_loop:
        mov     w6, wzr
        cmp     x1, x4
        beq     .decode_done

.read_byte:
        ldrb    w7, [x1], #1
        lsl     w6, w6, #7
        and     w8, w7, #127
        orr     w6, w6, w8
        tst     w7, #128
        bne     .read_byte

        str     w6, [x0], #4
        b       .decode_loop

.decode_done:
        sub     x0, x0, x5
        lsr     x0, x0, #2
        ret
