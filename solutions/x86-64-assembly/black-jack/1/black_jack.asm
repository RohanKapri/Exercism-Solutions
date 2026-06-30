C10 equ 10
CA equ 14
FALSE equ 0

section .text

global value_of_card
global higher_card
global value_of_ace
global is_blackjack
global can_split_pairs
global can_double_down

%macro value 2
    mov %2, %1
    mov rdx, 10

    cmp %1, C10
    cmovg %2, rdx

    mov rdx, 1
    cmp %1, CA
    cmove %2, rdx
%endmacro

value_of_card:
    value rdi, rax
    ret

higher_card:
    value rdi, r8
    value rsi, r9

    xor rdx, rdx
    mov rax, rdi
    
    cmp r8, r9
    cmovl rax, rsi
    cmove rdx, rsi
    
    ret

value_of_ace:
    cmp rdi, CA
    sete r8b

    cmp rsi, CA
    sete r9b

    mov rax, 11
    mov rcx, 1
    
    or r8b, r9b
    cmovnz rax, rcx

    value rdi, r8
    value rsi, r9

    add r8, r9
    cmp r8, 10
    cmovg rax, rcx
    
    ret

is_blackjack:
    cmp rdi, CA
    je .first

    cmp rsi, CA
    je .second

    mov al, FALSE
    ret

.first:
    value rsi, r8
    
    cmp r8, 10
    sete al
    ret
    
.second:
    value rdi, r8
    
    cmp r8, 10
    sete al
    ret

can_split_pairs:
    value rdi, r8
    value rsi, r9
    
    cmp r8, r9
    sete al
    ret

can_double_down:
    value rdi, r8
    value rsi, r9

    add r8, r9
    
    cmp r8, 9
    setge cl
    
    cmp r8, 11
    setle al
    
    and al, cl
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif