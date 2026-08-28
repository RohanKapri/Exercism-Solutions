; For my Shree DR.MDD
section .text
global steps
steps:
    mov rax, -1
    bt rdi, 31
    jc exit

    cmp rdi, 0
    jg main_loop
exit:
    ret

half_step:
    shr rdi, 1
main_loop:
    inc rax
    mov rbx, 1
    and rbx, rdi
    jz half_step

    cmp rdi, 1
    je exit
    mov r10, rdi
    inc rdi
    shl r10, 1
    add rdi, r10
    jmp main_loop

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
