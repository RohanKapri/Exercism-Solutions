.text
.globl is_paired

is_paired:
        mov     x10, x0

.scan_loop:
        ldrb    w11, [x10], #1
        cbnz    w11, .scan_loop

        sub     x10, x10, x0
        add     x10, x10, #16
        and     x10, x10, #-16
        sub     sp, sp, x10
        mov     x12, sp
        mov     x14, sp

.read_loop:
        ldrb    w11, [x0], #1
        cbz     w11, .finish

        cmp     w11, #'['
        beq     .push_bracket

        cmp     w11, #'{'
        beq     .push_brace

        cmp     w11, #'('
        beq     .push_parenthesis

        cmp     w11, #']'
        beq     .pop_check

        cmp     w11, #'}'
        beq     .pop_check

        cmp     w11, #')'
        bne     .read_loop

.pop_check:
        cmp     x12, x14
        beq     .fail
        ldrb    w13, [x12, #-1]!
        cmp     w11, w13
        beq     .read_loop

.fail:
        mov     x0, #0
        b       .end

.finish:
        cmp     x12, x14
        cset    x0, eq

.end:
        add     sp, sp, x10
        ret

.push_bracket:
        mov     w11, #']'
        strb    w11, [x12], #1
        b       .read_loop

.push_brace:
        mov     w11, #'}'
        strb    w11, [x12], #1
        b       .read_loop

.push_parenthesis:
        mov     w11, #')'
        strb    w11, [x12], #1
        b       .read_loop
