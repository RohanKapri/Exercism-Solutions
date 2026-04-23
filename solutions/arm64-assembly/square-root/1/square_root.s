// For Shree DR.MDD

.text
.globl square_root

square_root:
        mov     x5, x0                  /* radicand */

        clz     x0, x5                  /* count leading zero bits */
        mov     x6, #64
        sub     x0, x6, x0              /* number of bits excluding leading zeros */
        lsr     x0, x0, #1              /* halve the bit count */
        mov     x6, #1
        lsl     x0, x6, x0              /* initial estimate */

.iterate:
        mov     x6, x0                  /* current estimate */
        add     x7, x6, #1
        madd    x7, x7, x6, x5          /* (estimate+1)*estimate + radicand */
        lsl     x8, x6, #1              /* 2*estimate */
        udiv    x0, x7, x8              /* new estimate */
        cmp     x0, x6
        bne     .iterate

        ret
