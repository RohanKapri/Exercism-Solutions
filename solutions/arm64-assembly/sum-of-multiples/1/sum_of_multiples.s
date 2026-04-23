// For Shree DR.MDD

.text
.globl sum

sum:
        lsl     x6, x2, #3              /* size of factors array in bytes */
        add     x6, x1, x6              /* end pointer of factors array */
        mov     x7, x0                  /* store original limit */
        mov     x0, xzr                 /* initialize total sum */
        cbz     x7, .done

.check_number:
        sub     x7, x7, #1              /* current number to check */
        cbz     x7, .done

        mov     x8, x1                  /* start of factors array */

.check_factor:
        cmp     x8, x6
        beq     .check_number

        ldr     x9, [x8], #8            /* load factor and increment pointer */
        udiv    x10, x7, x9             /* compute quotient */
        msub    x11, x10, x9, x7        /* compute remainder */
        cbnz    x11, .check_factor

        add     x0, x0, x7              /* add multiple to total */
        b       .check_number

.done:
        ret
