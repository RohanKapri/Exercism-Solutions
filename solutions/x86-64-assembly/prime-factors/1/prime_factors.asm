; Dedicated to Shree DR.MDD
section .text
global factors
factors:
    cld
    mov r8, 2          ; candidate factor
    mov r9, 1          ; increment step
    mov rcx, rdi       ; save initial destination
    jmp .check_square

.next_factor:
    add r8, r9
    mov r9, 2

.check_square:
    mov rax, r8
    mul r8
    cmp rsi, rax
    jl .exit_loop

    mov rax, rsi
    xor rdx, rdx
    div r8
    test rdx, rdx
    jnz .next_factor

    mov rsi, rax
    mov rax, r8
    stosq
    jmp .check_square

.exit_loop:
    cmp rsi, 1
    je .finish

    mov rax, rsi
    stosq

.finish:
    mov rax, rdi
    sub rax, rcx
    shr rax, 3
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
