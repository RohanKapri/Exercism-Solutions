; For my Shree DR.MDD

default rel

FIRST equ 1
SECOND equ 2
THIRD equ 3
FOURTH equ 4
TEENTH equ 5
LAST equ 6

section .rodata
offset_table: dw -1, 307, 338, 1, 32, 62, 93, 123, 154, 185, 215, 246, 276, 307, 338
week_table: db -1, 7, 14, 21, 28, 19

section .text
global meetup

print_date:
    cld
    mov r10, rdx
    mov r11, rcx

    mov rax, rsi
    mov rdx, 0
    mov rcx, 1000
    div rcx
    add al, '0'
    stosb

    mov rax, rdx
    mov rdx, 0
    mov rcx, 100
    div rcx
    add al, '0'
    stosb

    mov rax, rdx
    mov rdx, 0
    mov rcx, 10
    div rcx
    add al, '0'
    stosb

    mov al, dl
    add al, '0'
    stosb

    mov al, '-'
    stosb

    mov rax, r10
    mov rdx, 0
    mov rcx, 10
    div rcx
    add al, '0'
    stosb

    mov al, dl
    add al, '0'
    stosb

    mov al, '-'
    stosb

    mov rax, r11
    mov rdx, 0
    mov rcx, 10
    div rcx
    add al, '0'
    stosb

    mov al, dl
    add al, '0'
    stosb

    mov al, 0
    stosb
    ret

day_of_week:
    cmp rsi, 2
    jg .calc

    sub rdi, 1
    add rsi, 12

.calc:
    mov r10, rdx
    add r10, rdi
    shr rdi, 2
    add r10, rdi

    mov rdx, 0
    mov rax, rdi
    mov rcx, 25
    div rcx
    sub r10, rax
    shr rax, 2
    add r10, rax

    lea rcx, [offset_table]
    mov dx, [rcx + rsi * 2]
    add r10, rdx

    mov rdx, 0
    mov rax, r10
    mov rcx, 7
    div rcx
    mov rax, rdx
    inc rax
    ret

week_concludes:
    cmp rdx, LAST
    je .month_end

    lea rcx, [week_table]
    xor rax, rax
    mov al, [rcx + rdx]
    ret

.month_end:
    cmp rsi, 2
    je .feb_check

    lea rcx, [offset_table]
    xor rdx, rdx
    xor rax, rax
    mov dx, [rcx + rsi * 2]
    mov ax, [rcx + rsi * 2 + 2]
    sub rax, rdx
    ret

.feb_check:
    mov rax, rdi
    and rax, 3
    jnz .feb_nonleap

    mov rdx, 0
    mov rax, rdi
    mov rcx, 100
    div rcx
    test rdx, rdx
    jnz .feb_leap

    and rax, 3
    jnz .feb_nonleap

.feb_leap:
    mov rax, 29
    ret

.feb_nonleap:
    mov rax, 28
    ret

meetup:
    push r12
    push rdi
    push rsi
    push rdx
    push r8
    push rsi
    push rdx

    mov rdi, rsi
    mov rsi, rdx
    mov rdx, rcx
    call week_concludes
    mov r12, rax

    mov rdx, rax
    pop rsi
    pop rdi
    call day_of_week

    pop rcx
    sub rcx, rax
    jle .print

    sub rcx, 7

.print:
    add rcx, r12
    pop rdx
    pop rsi
    pop rdi
    call print_date
    pop r12
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
