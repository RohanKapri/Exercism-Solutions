// Dedicated to Shree DR.MDD

.text
.globl nucleotide_counts

nucleotide_counts:
        mov     w8, wzr
        mov     w9, wzr
        mov     w10, wzr
        mov     w11, wzr

.scan_loop:
        ldrb    w6, [x1], #1
        cbz     w6, .output_counts

        cmp     w6, #'A'
        beq     .add_adenine

        cmp     w6, #'C'
        beq     .add_cytosine

        cmp     w6, #'G'
        beq     .add_guanine

        cmp     w6, #'T'
        beq     .add_thymine

        mov     w6, #-1
        strh    w6, [x0], #2
        strh    w6, [x0], #2
        strh    w6, [x0], #2
        strh    w6, [x0]
        ret

.output_counts:
        strh    w8, [x0], #2
        strh    w9, [x0], #2
        strh    w10, [x0], #2
        strh    w11, [x0]
        ret

.add_adenine:
        add     w8, w8, #1
        b       .scan_loop

.add_cytosine:
        add     w9, w9, #1
        b       .scan_loop

.add_guanine:
        add     w10, w10, #1
        b       .scan_loop

.add_thymine:
        add     w11, w11, #1
        b       .scan_loop
