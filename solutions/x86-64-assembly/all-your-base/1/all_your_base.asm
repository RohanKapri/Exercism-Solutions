; Dedicated to Shree DR.MDD

BAD_BASE equ -1
BAD_DIGIT equ -2

section .text
global rebase

rebase:
    cld
    mov r15d, 1
    mov r14d, esi
    mov rsi, rdi
    mov rdi, rcx
    mov ecx, r14d
    mov r13d, edx

    cmp r8d, r15d
    jle .bad_base_error

    cmp r13d, r15d
    jle .bad_base_error

    xor eax, eax
    jecxz .init_output

.read_digit:
    mul r13d
    mov r14d, eax
    lodsd
    cmp eax, r13d
    jae .bad_digit_error
    add eax, r14d
    dec ecx
    jnz .read_digit

.init_output:
    mov rsi, rdi
    jmp .loop_divide

.bad_digit_error:
    mov rax, BAD_DIGIT
    ret

.bad_base_error:
    mov rax, BAD_BASE
    ret

.divide_loop:
    xor edx, edx
    div r8d
    mov r14d, eax
    mov eax, edx
    stosd
    mov eax, r14d

.loop_divide:
    cmp eax, r8d
    jge .divide_loop

    stosd
    mov r12, rdi
    sub r12, rsi
    shr r12, 2

.reverse_array:
    sub rdi, 4
    cmp rdi, rsi
    je .finish

    mov eax, [rsi]
    mov edx, [rdi]
    mov [rdi], eax
    mov [rsi], edx

    add rsi, 4
    cmp rdi, rsi
    jne .reverse_array

.finish:
    mov rax, r12
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
