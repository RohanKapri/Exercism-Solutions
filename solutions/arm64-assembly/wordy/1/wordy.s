.equ WHAT_IS, 8
.equ PLUS, 8
.equ MINUS, 16
.equ MULTIPLIED_BY, 24
.equ DIVIDED_BY, 32
.equ QUESTION_MARK, 40

.data
what_is:        .string "What is "
plus:           .string " plus "
minus:          .string " minus "
multiplied_by:  .string " multiplied by "
divided_by:     .string " divided by "
question_mark:  .string "?"

word_array:
                .quad what_is
                .quad 0
                .quad plus
                .quad minus
                .quad multiplied_by
                .quad divided_by
                .quad question_mark
                .quad 0

.text
.globl answer

read_word:
        mov     x9, x1
        mov     x2, x14
        b       .next

.compare:
        ldrb    w11, [x10], #1
        cbz     w11, .match
        ldrb    w12, [x1], #1
        cmp     w12, w11
        beq     .compare

.next:
        mov     x1, x9
        ldr     x10, [x2], #8
        cbnz    x10, .compare
        b       reject

.match:
        sub     x2, x2, x14
        ret

read_number:
        mov     w10, #10
        ldrb    w11, [x1]
        cmp     w11, #'-'
        cset    x9, eq
        cinc    x1, x1, eq
        mov     x3, xzr
        ldrb    w11, [x1], #1
        add     w11, w11, #-48
        cmp     w11, w10
        bhs     reject

.accept_digit:
        madd    x3, x3, x10, x11
        ldrb    w11, [x1], #1
        add     w11, w11, #-48
        cmp     w11, w10
        blo     .accept_digit
        add     x1, x1, #-1
        cmp     x9, xzr
        cneg    x3, x3, ne
        ret

answer:
        mov     x15, lr
        adrp    x14, word_array
        add     x14, x14, :lo12:word_array
        bl      read_word
        add     x14, x14, #16
        bl      read_number
        mov     x4, x3

.read_operation:
        bl      read_word
        cmp     x2, QUESTION_MARK
        beq     .success
        bl      read_number
        cmp     x2, MINUS
        beq     .subtract
        cmp     x2, MULTIPLIED_BY
        beq     .multiply
        cmp     x2, DIVIDED_BY
        beq     .divide

.add:
        add     x4, x4, x3
        b       .read_operation

.subtract:
        sub     x4, x4, x3
        b       .read_operation

.multiply:
        mul     x4, x4, x3
        b       .read_operation

.divide:
        sdiv    x4, x4, x3
        b       .read_operation

.success:
        str     x4, [x0]
        mov     x0, #1
        ret     x15

reject:
        mov     x0, xzr
        ret     x15
