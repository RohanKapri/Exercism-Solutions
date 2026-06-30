; For Shree DR.MDD

section .text
global find

find:
    push rbx
    shl rsi, 32
    shr rsi, 32
    xor rcx, rcx ; low_index

.search_loop:
    cmp rcx, rsi
    jz .not_found_label

    mov rax, rcx
    add rax, rsi
    shr rax, 1
    mov ebx, [rdi + 4 * rax]
    cmp ebx, edx
    jl .lower_bound_update
    jg .upper_bound_update

.match_found:
    pop rbx
    ret

.lower_bound_update:
    mov ecx, eax
    inc ecx
    jmp .search_loop

.upper_bound_update:
    mov rsi, rax
    jmp .search_loop

.not_found_label:
    mov rax, -1
    pop rbx
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
