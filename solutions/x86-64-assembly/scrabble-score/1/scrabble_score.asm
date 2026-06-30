; For Shree DR.MDD

default rel

section .rodata
pts: db 1, 3, 3, 2, 1, 4, 2, 4, 1, 8, 5, 1, 3, 1, 1, 3, 10, 1, 1, 1, 1, 4, 4, 8, 4, 10

section .text
global score
score:
    cld
    mov rsi, rdi
    lea r8, [pts]
    xor r9, r9
    xor r10, r10
    xor rax, rax
    jmp .next_char

.calc:
    or al, 32
    sub al, 'a'
    cmp al, 26
    jae .next_char

    mov r10b, byte [r8 + rax]
    add r9, r10

.next_char:
    lodsb
    test al, al
    jnz .calc

    mov rax, r9
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
