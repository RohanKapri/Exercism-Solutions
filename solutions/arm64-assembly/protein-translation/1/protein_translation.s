.equ A, 0x41
.equ U, 0x55

.equ AUG, 0x4755
.equ UUU, 0x5555
.equ UUC, 0x4355
.equ UUA, 0x4155
.equ UUG, 0x4755
.equ UCU, 0x5543
.equ UCC, 0x4343
.equ UCA, 0x4143
.equ UCG, 0x4743
.equ UAU, 0x5541
.equ UAC, 0x4341
.equ UGU, 0x5547
.equ UGC, 0x4347
.equ UGG, 0x4747
.equ UAA, 0x4141
.equ UAG, 0x4741
.equ UGA, 0x4147

.macro LOAD str
        adrp    x9, \str
        add     x9, x9, :lo12:\str
.endm

.macro CHECK codon
        mov     w13, \codon
        cmp     w12, w13
        beq     .copy_string
.endm

.macro CHECKS codon
        mov     w13, \codon
        cmp     w12, w13
        beq     .stop
.endm

.section .rodata
methionine:    .string "Methionine\n"
phenylalanine: .string "Phenylalanine\n"
leucine:       .string "Leucine\n"
serine:        .string "Serine\n"
tyrosine:      .string "Tyrosine\n"
cysteine:      .string "Cysteine\n"
tryptophan:    .string "Tryptophan\n"

.text
.globl proteins
proteins:
        mov     x10, x0
        strb    wzr, [x10]
        b       .read_codon

.copy_string:
        ldrb    w11, [x9], #1
        strb    w11, [x10], #1
        cbnz    w11, .copy_string
        add     x10, x10, #-1
        add     x1, x1, #3

.read_codon:
        ldrb    w11, [x1]
        cbz     w11, .stop
        ldrb    w12, [x1, #1]
        cbz     w12, .invalid
        ldrh    w12, [x1, #1]

        mov     w13, A
        cmp     w11, w13
        beq     .a

        mov     w13, U
        cmp     w11, w13
        beq     .u

        b .invalid

.a:
        LOAD methionine
        CHECK AUG
        b .invalid

.u:
        LOAD phenylalanine
        CHECK UUU
        CHECK UUC

        LOAD leucine
        CHECK UUA
        CHECK UUG

        LOAD serine
        CHECK UCU
        CHECK UCC
        CHECK UCA
        CHECK UCG

        LOAD tyrosine
        CHECK UAU
        CHECK UAC

        LOAD cysteine
        CHECK UGU
        CHECK UGC

        LOAD tryptophan
        CHECK UGG

        CHECKS UAA
        CHECKS UAG
        CHECKS UGA

.invalid:
        strb    wzr, [x0]

.stop:
        ret
