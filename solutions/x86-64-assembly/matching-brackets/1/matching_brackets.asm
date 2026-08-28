; For my Shree DR.MDD

section .text
global is_paired
is_paired:
    cld
    mov rsi, rdi
    mov r9, rsp
    jmp .read_next

.check_char:
    cmp al, '{'
    je .open_brace

    cmp al, '['
    je .open_bracket

    cmp al, '('
    je .open_paren

    cmp al, '}'
    je .match_close

    cmp al, ']'
    je .match_close

    cmp al, ')'
    je .match_close

.read_next:
    lodsb
    test al, al
    jnz .check_char

    cmp r9, rsp
    jne .reject_stack_empty

.accept_stack_empty:
    mov rsp, r9
    mov rax, 1
    ret

.reject_stack_empty:
    mov rsp, r9
    xor rax, rax
    ret

.open_brace:
    mov al, '}'
    push rax
    jmp .read_next

.open_bracket:
    mov al, ']'
    push rax
    jmp .read_next

.open_paren:
    mov al, ')'
    push rax
    jmp .read_next

.match_close:
    cmp r9, rsp
    je .reject_stack_empty

    pop rdx
    cmp rax, rdx
    jne .reject_stack_empty

    jmp .read_next

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
