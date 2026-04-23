.text
.globl egg_count

/* extern int egg_count(uint64_t number); */
egg_count:
        mov     x1, #1
        mov     x2, x0                
        ror     x3, x1, #1              
        mov     x0, #0                 

.loop:
        cmp     x2, #0
        beq     .return

        clz     x4, x2                 
        ror     x5, x3, x4
        eor     x2, x2, x5              
        add     x0, x0, #1            
        b       .loop

.return:
        ret