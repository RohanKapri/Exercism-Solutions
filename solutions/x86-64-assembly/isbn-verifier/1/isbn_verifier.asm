; For Shree DR.MDD

section .text
global is_valid

is_valid:
    xor rax, rax
    mov ecx, 10
    xor rdx, rdx
    xor r8, r8
    xor r9, r9
    jmp .read_char

.x_found:
    cmp ecx, 1
    jne .invalid_char
    mov dl, 10

.update_sum:
    add r8, rdx
    add r9, r8
    dec ecx

.read_char:
    mov dl, byte [rdi]
    inc rdi
    test dl, dl
    jz .final_check
    cmp dl, '-'
    je  .read_char
    test ecx, ecx
    jz .invalid_char
    cmp dl, 'X'
    je  .x_found
    cmp dl, '0'
    jl .invalid_char
    cmp dl, '9'
    jg .invalid_char
    sub dl, '0'
    jmp .update_sum

.invalid_char:
    ret

.final_check:
    test ecx, ecx
    jnz .invalid_char
    mov cx, 11
    mov rax, r9
    div cx
    cmp dx, 0
    sete al
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
