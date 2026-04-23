.equ WRONG_PARITY, -1

.text
.globl transmit_sequence
.globl decode_message

transmit_sequence:
        mov     x20, x0
        cbz     x2, .success

        mov     x7, 7
        mov     x21, xzr
        mov     x22, xzr
        b       .read_next

.odd_bit:
        orr     x6, x6, #1

.even_bit:
        strb    w6, [x0], #1

        cmp     x21, 7
        beq     .encode_bits

        cbnz    x2, .read_next

        cbz     x21, .success
        sub     x14, x7, x21
        mov     x21, x7
        lsl     x22, x22, x14
        b       .encode_bits

.read_next:
        lsl     x22, x22, #8
        ldrb    w11, [x1], #1
        add     x2, x2, #-1
        orr     x22, x22, x11
        add     x21, x21, #8

.encode_bits:
        add     x21, x21, #-7
        lsr     x13, x22, x21
        lsl     x6, x13, #1
        and     x13, x13, #127

.check_parity:
        cbz     x13, .even_bit

        neg     x14, x13
        and     x14, x13, x14
        sub     x13, x13, x14
        cbz     x13, .odd_bit

        neg     x14, x13
        and     x14, x13, x14
        sub     x13, x13, x14
        b       .check_parity

.success:
        sub     x0, x0, x20
        ret

decode_message:
        mov     x20, x0
        mov     x21, xzr
        mov     x22, xzr
        b       .check_remaining

.no_write:
        mov     x21, #7

.read_bits:
        lsl     x11, x22, #7
        ldrb    w12, [x1], #1
        add     x2, x2, #-1
        mov     x13, x12
        cbz     x12, .consume_bits

.check_decode_parity:
        neg     x14, x13
        and     x14, x13, x14
        sub     x13, x13, x14
        cbz     x13, .failure

        neg     x14, x13
        and     x14, x13, x14
        sub     x13, x13, x14
        cbnz     x13, .check_decode_parity

.consume_bits:
        lsr     x22, x12, #1
        cbz     x21, .no_write

        orr     x11, x11, x22
        add     x21, x21, #-1
        lsr     x11, x11, x21
        strb    w11, [x0], #1

.check_remaining:
        cbnz    x2, .read_bits

.decode_success:
        sub     x0, x0, x20
        ret

.failure:
        mov     x0, WRONG_PARITY
        ret
