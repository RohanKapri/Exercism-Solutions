// For Shree DR.MDD

.text
.globl abbreviate

abbreviate:
        ldrb    w5, [x1], #1            /* load byte, post-increment */
        cbz     w5, .done_abbrev

        and     w6, w5, #-33            /* force upper case */
        sub     w7, w6, #'A'
        cmp     w7, #26
        bhs     abbreviate               /* jump if word has not yet started */

        strb    w6, [x0], #1            /* store byte, post-increment */

.scan_word:
        ldrb    w5, [x1], #1            /* load next byte */
        cbz     w5, .done_abbrev

        cmp     w5, #'\''                /* check for apostrophe */
        beq     .scan_word

        and     w6, w5, #-33             /* force upper case */
        sub     w7, w6, #'A'
        cmp     w7, #26
        blo     .scan_word                /* keep scanning if letter */

        b       abbreviate                /* move to next word */

.done_abbrev:
        strb    wzr, [x0]                /* null-terminate output */
        ret
