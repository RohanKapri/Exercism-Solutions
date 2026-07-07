section .text

global create
global add_minutes
global subtract_minutes
global equal

subtract_minutes:
    ; rdi - hour, as a int64_t
    ; rsi - minute, as a int64_t
    ; rdx - value, in minutes, to be subtracted, as a int64_t
    ; return is a struct of 2 uint8_t in rax

    neg rdx ; value = -value

    ; function fallthrough
    ; execution continues in add_minutes

add_minutes:
    ; rdi - hour, as a int64_t
    ; rsi - minute, as a int64_t
    ; rdx - value, in minutes, to be added, as a int64_t
    ; return is a struct of 2 uint8_t in rax

    add rsi, rdx ; minute += value

    ; function fallthrough
    ; execution continues in create

create:
    ; rdi - hour, as a int64_t
    ; rsi - minute, as a int64_t
    ; return is a struct of 2 uint8_t in rax

    mov rax, rsi
    
    mov r8, 60
    cqo ; sets rdx bits according to rax sign
    idiv r8 ; signed division of minutes by 60
            ; rax now holds num of hours to be added
            ; rdx holds num of minutes

    add rax, rdi
    lea rdi, [rax - 1]
    
    lea rcx, [rdx + 60]
    cmp rdx, 0
    cmovge rcx, rdx
    cmovl rax, rdi

    mov r8, 24
    cqo ; sets rdx bits according to rax sign
    idiv r8 ; signed division of num of hours by 24
            ; rdx holds num of hours

    lea rax, [rdx + 24]
    cmp rdx, 0
    cmovge rax, rdx

    ; the first 8 bits of rax already holds num of hours
    ; the number of minutes must be added in the following byte

    mov ah, cl
    ret

equal:
    ; clock1 is stored in the lowest 2 bytes of rdi
    ; clock2 is stored in the lowest 2 bytes of rsi
    ; return is a boolean in rax

    cmp di, si
    sete al ; sets rax if rdi equals to rsi. Clears otherwise

    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif