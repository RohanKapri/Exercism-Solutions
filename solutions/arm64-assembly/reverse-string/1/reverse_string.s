.text
.globl reverse
reverse:
        mov     x1, x0
.scan:
        ldrb    w2, [x1], #1            
        cbnz    w2, .scan

        sub     x1, x1, #1
        cmp     x1, x0
        beq     .done                  
.reverse:
        sub     x1, x1, #1
        cmp     x1, x0
        beq     .done                  

        ldrb    w2, [x1]
        ldrb    w3, [x0]
        strb    w3, [x1]
        strb    w2, [x0], #1            
        cmp     x1, x0
        bne     .reverse
.done:
        ret