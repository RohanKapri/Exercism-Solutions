; For Shree DR.MDD

default rel

section .rodata
    nts db 'A', 'C', 'G', 'T'

section .text
global nucleotide_counts
nucleotide_counts:
    lea r9, [nts]

    mov qword [rsi], 0
    mov qword [rsi + 8], 0
    mov qword [rsi + 16], 0
    mov qword [rsi + 24], 0
    
    xor rcx, rcx
process_loop:
    mov al, byte [rdi + rcx]
    cmp al, 0 
    je finish
    mov r8, -1
search_index:
    add r8, 1
    cmp r8, 4
    je invalid_char
    cmp byte [r9 + r8], al
    jne search_index
    add qword [rsi + 8 * r8], 1
    add rcx, 1
    jmp process_loop
invalid_char:
    mov qword [rsi], -1
    mov qword [rsi + 8], -1
    mov qword [rsi + 16], -1
    mov qword [rsi + 24], -1
finish:
    ret
    
%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
