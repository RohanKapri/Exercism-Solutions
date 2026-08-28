; Dedicated to my Shree DR.MDD

default rel

AUG equ 0x00415547
UUU equ 0x00555555
UUC equ 0x00555543
UUA equ 0x00555541
UUG equ 0x00555547
UCU equ 0x00554355
UCC equ 0x00554343
UCA equ 0x00554341
UCG equ 0x00554347
UAU equ 0x00554155
UAC equ 0x00554143
UGU equ 0x00554755
UGC equ 0x00554743
UGG equ 0x00554747
UAA equ 0x00554141
UAG equ 0x00554147
UGA equ 0x00554741

section .data
start_codon: db "Methionine", 0
phe_codon: db "Phenylalanine", 0
leu_codon: db "Leucine", 0
ser_codon: db "Serine", 0
tyr_codon: db "Tyrosine", 0
cys_codon: db "Cysteine", 0
trp_codon: db "Tryptophan", 0

temp_buffer: dq 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

section .text
global proteins
proteins:
    cld
    mov rsi, rdi
    lea r11, [temp_buffer]
    mov rdi, r11
    jmp .read_codon

.store_name:
    mov rax, rcx
    stosq

.read_codon:
    xor rax, rax
    lodsb
    test al, al
    jz .done

    mov rdx, rax
    lodsb
    test al, al
    jz .done

    shl rdx, 8
    or rdx, rax
    lodsb
    test al, al
    jz .done

    shl rdx, 8
    or rdx, rax

    lea rcx, [start_codon]
    cmp rdx, AUG
    je .store_name

    lea rcx, [phe_codon]
    cmp rdx, UUU
    je .store_name

    cmp rdx, UUC
    je .store_name

    lea rcx, [leu_codon]
    cmp rdx, UUA
    je .store_name

    cmp rdx, UUG
    je .store_name

    lea rcx, [ser_codon]
    cmp rdx, UCU
    je .store_name

    cmp rdx, UCC
    je .store_name

    cmp rdx, UCA
    je .store_name

    cmp rdx, UCG
    je .store_name

    lea rcx, [tyr_codon]
    cmp rdx, UAU
    je .store_name

    cmp rdx, UAC
    je .store_name

    lea rcx, [cys_codon]
    cmp rdx, UGU
    je .store_name

    cmp rdx, UGC
    je .store_name

    lea rcx, [trp_codon]
    cmp rdx, UGG
    je .store_name

.done:
    xor rax, rax
    stosq
    mov rax, r11
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
