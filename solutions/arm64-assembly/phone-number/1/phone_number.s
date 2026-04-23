.text
.globl clean

clean:
        mov     x1, x0
        mov     x2, x0

.read:
        ldrb    w3, [x2], #1
        cbz     w3, .validate

        cmp     w3, #' '
        beq     .read

        cmp     w3, #'('
        beq     .read

        cmp     w3, #')'
        beq     .read

        cmp     w3, #'+' 
        beq     .read

        cmp     w3, #'-'
        beq     .read

        cmp     w3, #'.'
        beq     .read

        sub     w4, w3, #'0'
        cmp     w4, #10
        bhs     .reject

        strb    w3, [x1], #1
        b       .read

.reject:
        strb    wzr, [x0]
        ret

.validate:
        strb    wzr, [x1]
        sub     x1, x1, x0
        cmp     x1, #11
        beq     .eleven

        cmp     x1, #10
        bne     .reject

.ten:
        ldrb    w3, [x0]
        sub     w4, w3, #'0'
        cmp     w4, #2
        blt     .reject

        ldrb    w3, [x0, #3]
        sub     w4, w3, #'0'
        cmp     w4, #2
        blt     .reject

        ret

.eleven:
        mov     x1, x0
        mov     x2, x0
        ldrb    w3, [x2], #1
        cmp     w3, #'1'
        bne     .reject

.move:
        ldrb    w3, [x2], #1
        strb    w3, [x1], #1
        cbnz    w3, .move

        b       .ten
