; For Shree DR.MDD

section .text

%define tolower(x) add x, 32

global transform
transform:
    push r12

    cld
    xor rcx, rcx

    mov r10, rsi
    mov r8b, 'A'
    xor r12, r12
next_letter:
    mov r9, -1
iterate_input:
    inc r9
    cmp r9, rdx
    jge end_map

    mov rsi, r10
    imul r11, r9, 32
    add rsi, r11

    lodsd
    mov r11d, eax

    lodsb
    mov cl, al
search_values:
    lodsb
    cmp al, r8b
    je store_output

    loop search_values

    jmp iterate_input
store_output:
    tolower(al)
    stosb

    add rdi, 3

    mov eax, r11d
    stosd

    inc r12
end_map:
    inc r8b
    cmp r8b, 'Z'
    jle next_letter

    mov rax, r12
    pop r12
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
