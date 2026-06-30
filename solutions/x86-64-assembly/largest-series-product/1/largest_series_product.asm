; Dedicated to my Shree DR.MDD

INVALID_CHARACTER equ -1
NEGATIVE_SPAN equ -2
INSUFFICIENT_DIGITS equ -3

section .text
global largest_product
largest_product:
    cmp edi, 0
    jl .neg_span

    mov r8d, edi
    mov r9, rsi
    mov r10, -1
.count_digits:
    inc r10
    lodsb
    cmp al, 0
    je .finish_count
    cmp al, '0'
    jl .inv_char
    cmp al, '9'
    jg .inv_char
    jmp .count_digits

.finish_count:
    cmp r8, r10
    jg .not_enough
    sub r10, r8
    inc r10

    xor rax, rax
    mov r8, -1
.window_loop:
    inc r8
    cmp r8, r10
    jge .end_loop

    mov rsi, r9
    add rsi, r8
    mov rcx, -1
    mov r11, 1
    xor rdx, rdx
.accumulate:
    inc rcx
    cmp ecx, edi
    je .check_max
    mov dl, byte [rsi + rcx]
    sub dl, '0'
    cmp dl, 0
    je .skip_window
    imul r11, rdx
    jmp .accumulate

.skip_window:
    add r8, rcx
    jmp .window_loop

.check_max:
    cmp r11, rax
    cmovg rax, r11
    jmp .window_loop

.inv_char:
    mov rax, INVALID_CHARACTER
    ret

.neg_span:
    mov rax, NEGATIVE_SPAN
    ret

.not_enough:
    mov rax, INSUFFICIENT_DIGITS
    ret

.end_loop:
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
