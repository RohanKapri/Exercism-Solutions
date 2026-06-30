; For Shree DR.MDD

section .text
global abbreviate
abbreviate:
    cld
    mov rdx, rdi
    mov rdi, rsi
    mov rsi, rdx

.next_letter:
    lodsb
    test al, al
    jz .finish

    and al, 0xdf
    cmp al, 'A'
    jl .next_letter
    cmp al, 'Z'
    jg .next_letter

    stosb

.skip_word:
    lodsb
    test al, al
    jz .finish

    cmp al, 0x27
    je .skip_word

    and al, 0xdf
    cmp al, 'A'
    jl .next_letter
    cmp al, 'Z'
    jg .next_letter

    jmp .skip_word

.finish:
    stosb
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
