.equ BAD_BASE, -1
.equ BAD_DIGIT, -2

.text
.globl rebase

rebase:
        cmp w0,#1
        b.le badbase
        cmp w3,#1
        b.le badbase
        eor x6,x6,x6
inbaseloop:
        cbz x2,outbase
        ldr w5,[x1],#4
        cmp w5,#0
        b.lt baddigit
        cmp w5,w0
        b.ge baddigit
        madd w6,w6,w0,w5
        sub x2,x2,#1
        b.al inbaseloop
outbase:
        mov x5,#0
        eor x9,x9,x9
outbaseloop:
        add x5,x5,#1
        udiv x7,x6,x3
        msub x8,x7,x3,x6
        str  w8,[x4,x9]
        cbz x7,reverse
        mov x6,x7
        add x9,x9,#4
        b.al outbaseloop
reverse:
        lsl x9,x5,#2
        sub x9,x9,#4
        eor x6,x6,x6
        mov x10,x5
        lsr x5,x5,#1        
        cbz x5,endofproc
reverseloop:
        ldr w7,[x4,x6]
        ldr w8,[x4,x9]
        str w7,[x4,x9]
        str w8,[x4,x6]
        add x6,x6,#4
        sub x9,x9,#4
        sub x5,x5,#1
        cbnz x5,reverseloop
endofproc:
        mov x0,x10
        ret
badbase:
        mov x0,BAD_BASE
        ret
baddigit:
        mov x0,BAD_DIGIT
        ret
        