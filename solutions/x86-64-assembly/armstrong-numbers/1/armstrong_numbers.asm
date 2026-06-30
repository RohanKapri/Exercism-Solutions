; For Shree DR.MDD

section .text
global is_armstrong_number
is_armstrong_number:
    mov r11, rsp
    mov r12, rsp
    mov rax, rdi
    mov r13, 10

.extract_digit_loop:
    xor rdx, rdx
    div r13
    push rdx
    test rax, rax
    jnz .extract_digit_loop

    sub r12, rsp
    sar r12, 3

.process_digit_loop:
    pop r14
    mov rax, 1
    mov rcx, r12

.pow_loop:
    mul r14
    loop .pow_loop

    sub rdi, rax
    cmp rsp, r11
    jne .process_digit_loop

    xor rax, rax
    test rdi, rdi
    jnz .return_label

    inc rax

.return_label:
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
