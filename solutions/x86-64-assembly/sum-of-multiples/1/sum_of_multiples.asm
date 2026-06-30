; Dedicated to my Shree DR.MDD

section .text
global sum
sum:
    mov r12, rdi
    
    push rbp
    mov rbp, rsp
    sub rsp, r12

    lea rdi, [rsp]
    mov rcx, r12
    mov al, 0
    cld
    rep stosb

    lea rdi, [rsp]
    mov rcx, -1
process_factors:
    inc rcx
    cmp rcx, rdx
    jge finish_factors

    lodsq
    cmp rax, 0
    jle process_factors

    mov r13, rax
mark_multiples:
    cmp r13, r12
    jge process_factors

    mov byte [rdi + r13], 1
    add r13, rax
    jmp mark_multiples

finish_factors:
    xor rax, rax
    mov rcx, r12
sum_multiples:
    mov r14b, byte [rdi + rcx]
    xor r15, r15
    cmp r14b, 1
    cmove r15, rcx
    add rax, r15
    loop sum_multiples

finalize_sum:
    mov rsp, rbp
    pop rbp
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
