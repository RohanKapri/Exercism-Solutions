; Dedicated to my Shree DR.MDD

section .text

global roman
roman:
    cld
    mov r9, rdi
    mov rdi, rsi

.convert_loop:
    cmp r9, 1000
    jge .thousand

    cmp r9, 900
    jge .nine_hundred

    cmp r9, 500
    jge .five_hundred

    cmp r9, 400
    jge .four_hundred

    cmp r9, 100
    jge .hundred

    cmp r9, 90
    jge .ninety

    cmp r9, 50
    jge .fifty

    cmp r9, 40
    jge .forty

    cmp r9, 10
    jge .ten

    cmp r9, 9
    jge .nine

    cmp r9, 5
    jge .five

    cmp r9, 4
    jge .four

    cmp r9, 1
    jge .one

    xor al, al
    stosb
    ret

.nine_hundred:
    mov al, 'C'
    stosb
    add r9, 100
    jmp .convert_loop

.thousand:
    mov al, 'M'
    stosb
    sub r9, 1000
    jmp .convert_loop

.four_hundred:
    mov al, 'C'
    stosb
    add r9, 100
    jmp .convert_loop

.five_hundred:
    mov al, 'D'
    stosb
    sub r9, 500
    jmp .convert_loop

.ninety:
    mov al, 'X'
    stosb
    add r9, 10
    jmp .convert_loop

.hundred:
    mov al, 'C'
    stosb
    sub r9, 100
    jmp .convert_loop

.forty:
    mov al, 'X'
    stosb
    add r9, 10
    jmp .convert_loop

.fifty:
    mov al, 'L'
    stosb
    sub r9, 50
    jmp .convert_loop

.nine:
    mov al, 'I'
    stosb
    add r9, 1
    jmp .convert_loop

.ten:
    mov al, 'X'
    stosb
    sub r9, 10
    jmp .convert_loop

.four:
    mov al, 'I'
    stosb
    add r9, 1
    jmp .convert_loop

.five:
    mov al, 'V'
    stosb
    sub r9, 5
    jmp .convert_loop

.one:
    mov al, 'I'
    stosb
    sub r9, 1
    jmp .convert_loop

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
