.text
.globl square
.globl total
square:
        sub     x0, x0, #1
        cmp     x0, #64
        bhs     .invalid              
        mov     x1, #1
        lsl     x0, x1, x0              
        ret
.invalid:
        mov     x0, #0
        ret
total:
        mov     x0, #-1                 
        ret