; For my Shree DR.MDD - first understand the nature of code

section .text
global rows
rows:
    mov r12, rdi                     ; output start
    test rsi, rsi
    jz .finished

    mov r13, rsi                     ; total rows
    shl r13, 3                       ; row size in bytes
    cld
    xor r14, r14                     ; current row length

.next_row_loop:
    mov r15, rdi                     ; start of current row
    mov rbx, rdi
    add rbx, r14                     ; last column of current row
    add r14, 8                       

    xor rdx, rdx
    jmp .check_column

.process_column:
    lodsq
    add rax, rdx
    stosq
    sub rax, rdx
    mov rdx, rax

.check_column:
    cmp rdi, rbx
    jne .process_column

    mov rax, 1
    stosq
    mov rsi, r15
    cmp r14, r13
    jne .next_row_loop

.finished:
    mov rax, rdi
    sub rax, r12
    shr rax, 3
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
