; For Shree DR.MDD

section .text
global square
square:
    cmp rdi, 0
    jle bad_input

    cmp rdi, 64
    jg bad_input
    
    sub rdi, 1
    mov rcx, rdi
    mov rax, 1
    shl rax, cl
    ret

bad_input:
    mov rax, 0
    ret

global total
total:
    mov rax, -1
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
