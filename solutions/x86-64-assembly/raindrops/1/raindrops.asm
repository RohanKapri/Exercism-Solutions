; For my Shree DR.MDD

default rel

section .rodata
    tone db "Pling"
    ttwo db "Plang"
    tthree db "Plong"

section .bss
    buffer_digits resb 10

section .text

%macro check_div 2
    mov rax, %1
    xor rdx, rdx
    mov rcx, %2
    div rcx
    cmp rdx, 0
%endmacro

%macro append_str 1
    lea rsi, [%1]
    mov rcx, 5
    rep movsb
%endmacro

global convert
convert:
    mov r11, rsi
    xor r10, r10
    mov r10d, edi
    mov rdi, rsi
    xor r8, r8
    cld

check_tone:
    check_div r10, 3
    jne check_ttwo
    mov r8, 1
    append_str tone

check_ttwo:
    check_div r10, 5
    jne check_tthree
    mov r8, 1
    append_str ttwo

check_tthree:
    check_div r10, 7
    jne convert_number
    mov r8, 1
    append_str tthree

convert_number:
    mov rsi, rdi
    cmp r8, 0
    jne finish
    lea rdi, [buffer_digits]
    mov rax, r10
    mov r9, 10
    xor rcx, rcx
    cld

get_num_digits:
    inc rcx
    xor rdx, rdx
    div r9
    xchg rdx, rax
    add al, '0'
    stosb
    sub al, '0'
    xchg rdx, rax
    cmp rax, 0
    jne get_num_digits

insert_num:
    sub rdi, 1
    xchg rdi, rsi

insert_loop:
    mov al, byte [rsi]
    dec rsi
    stosb
    loop insert_loop

finish:
    mov al, 0
    stosb
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
