; For Shree DR.MDD

section .text
global is_isogram

is_isogram:
    mov r9, 1
    xor r10, r10
    jmp .next_char

.check_char:
    or dl, 32
    cmp dl, 97
    jl .next_char
    cmp dl, 122
    jg .next_char
    sub dl, 97
    mov cl, dl
    mov rdx, r9
    shl rdx, cl
    test r10, rdx
    jnz .not_isogram
    or r10, rdx

.next_char:
    mov dl, byte [rdi]
    inc rdi
    test dl, dl
    jnz .check_char
    mov rax, 1
    ret

.not_isogram:
    xor rax, rax
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
