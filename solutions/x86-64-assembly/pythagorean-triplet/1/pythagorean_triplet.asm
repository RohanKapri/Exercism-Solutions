; For my Shree DR.MDD - first understand the nature of code

section .text
global triplets_with_sum
triplets_with_sum:
    push rsi
    push rdi
    push rbx
    push r12
    push r13
    push r14
    push r15

    mov r12, rdx
    xor rdx, rdx
    mov rax, rdi
    mov rbx, 3
    div rbx
    mov rbx, rax
    xor rax, rax

    mov rdx, r12
    mov r11, rdi
    dec r11

outer_loop:
    dec r11
    cmp r11, rbx
    jl end_triplets

    mov r8, rdi
    sub r8, r11
    mov r12, r8
    shr r12, 1

    xor r9, r9

inner_loop:
    inc r9
    cmp r9, r12
    jg outer_loop

    mov r10, r8
    sub r10, r9

    mov r13, r9
    imul r13, r13
    mov r14, r10
    imul r14, r14
    mov r15, r11
    imul r15, r15

    add r13, r14
    cmp r13, r15
    jne inner_loop

    inc rax
    mov qword [rsi], r9
    add rsi, 8
    mov qword [rdx], r10
    add rdx, 8
    mov qword [rcx], r11
    add rcx, 8

    jmp inner_loop

end_triplets:
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
    pop rdi
    pop rsi
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
