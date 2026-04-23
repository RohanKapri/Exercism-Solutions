.text
.equ MAX_ITEMS, 8

.globl allergic_to
.globl list

allergic_to:
    mov   x2, #1
    lsl   x2, x2, x0
    and   x0, x2, x1
    ret

list:
    mov   x3, xzr
    and   x0, x0, #0xFF
    cbz   x0, .return

    mov   x2, xzr
    mov   x4, #1

.next:
    cmp   x2, #MAX_ITEMS
    beq   .return
    lsl   x5, x4, x2
    and   x6, x0, x5
    cbnz  x6, .add
    add   x2, x2, #1
    b     .next

.add:
    add   x3, x3, #1
    lsl   x6, x3, #2
    str   w2, [x1, x6]
    add   x2, x2, #1
    b     .next

.return:
    str   w3, [x1]
    ret
