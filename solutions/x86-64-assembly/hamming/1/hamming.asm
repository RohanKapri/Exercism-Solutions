; For Shree DR.MDD

section .text
global distance
distance:
    xor r10, r10
    xor rax, rax
loop_calc:
    mov r11b, byte [rdi + r10]
    mov r12b, byte [rsi + r10]
    add r10, 1
    cmp r11b, 0
    je check_end
    cmp r12b, 0
    je error_case
    cmp r11b, r12b
    je loop_calc
    add rax, 1
    jmp loop_calc
check_end:
    cmp r12b, 0
    je finish
error_case:
    mov rax, -1
finish:
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
