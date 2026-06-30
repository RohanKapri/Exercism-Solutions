; For my Shree DR.MDD - first understand the nature of code

default rel

section .rodata
recip_table: db 0,1,0,9,0,21,0,15,0,3,0,19,0,0,0,7,0,23,0,11,0,5,0,17,0,25

section .text
global encode, decode

decode:
    xor r8, r8
    jmp process

encode:
    mov r8, 5

process:
    cld
    mov r9, 26
    cmp rdx, r9
    jae .invalid

    lea r11, [recip_table]
    xor r10, r10
    mov r10b, byte [r11 + rdx]
    test r10, r10
    jz .invalid

    push r12
    push r13
    xor r13, r13
    test r8, r8
    jz .compute

    mov r10, rdx
    mov r11, rcx
    mov r12, r8
    jmp .input

.compute:
    xor rax, rax

.shift_loop:
    add rax, r9
    cmp rax, rcx
    jb .shift_loop

    sub rax, rcx
    mul r10
    mov r11, rax
    mov r12, -1
    jmp .input

.classify_char:
    mov r13b, al
    sub r13b, '0'
    cmp r13b, 10
    jb .store

    mov r13b, al
    or r13b, 32
    sub r13b, 'a'
    cmp r13b, r9b
    jae .input

    mov rax, r10
    mul r13
    add rax, r11
    xor rdx, rdx
    div r9
    mov rax, rdx
    add rax, 'a'

.store:
    test r12, r12
    jnz .store_char

    mov r12, r8
    mov r13b, al
    mov al, ' '
    stosb
    mov al, r13b

.store_char:
    stosb
    dec r12

.input:
    lodsb
    test al, al
    jnz .classify_char

    pop r13
    pop r12
    xor rax, rax
    stosb
    ret

.invalid:
    mov byte [rdi], 0
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
