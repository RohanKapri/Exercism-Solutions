; For my Shree DR.MDD

default rel

section .rodata
book_prices: dq 0, 3000, 2560, 2160, 1520, 800

section .text
global total
total:
    cld
    sub rsp, 48
    xor rax, rax
    mov rcx, 5

.clear_counts:
    mov [rsp + 8*rcx], rax
    loop .clear_counts

    mov rcx, rdi
    jrcxz .sort_books

.read_books:
    lodsw
    inc qword [rsp + 8*rax]
    loop .read_books

.sort_books:
    xor r8, r8
    mov rcx, 4

.scan_books:
    mov r9, qword [rsp + 8*rcx]
    mov r10, qword [rsp + 8*rcx + 8]
    cmp r9, r10
    jbe .next_pair_scan

    mov qword [rsp + 8*rcx], r10
    mov qword [rsp + 8*rcx + 8], r9
    inc r8

.next_pair_scan:
    loop .scan_books

    test r8, r8
    jnz .sort_books

.calc_diffs:
    mov rdx, qword [rsp + 8]
    mov r8, qword [rsp + 16]
    mov r9, qword [rsp + 24]
    mov r10, qword [rsp + 32]
    mov r11, qword [rsp + 40]
    sub r11, r10
    sub r10, r9
    sub r9, r8
    sub r8, rdx
    mov qword [rsp + 16], r8
    mov qword [rsp + 24], r9
    mov qword [rsp + 32], r10
    mov qword [rsp + 40], r11

    mov r8, qword [rsp + 8]
    mov r9, qword [rsp + 16]
    mov r10, qword [rsp + 24]
    mov r11, r10
    cmp r8, r10
    cmovb r11, r8
    sub r8, r11
    sub r10, r11
    shl r11, 1
    add r9, r11
    mov qword [rsp + 8], r8
    mov qword [rsp + 16], r9
    mov qword [rsp + 24], r10

    xor r10, r10
    lea r11, [book_prices]
    mov rcx, 5

.compute_total:
    mov rax, qword [rsp + rcx*8]
    mov rdx, qword [r11 + rcx*8]
    mul rdx
    add r10, rax
    loop .compute_total

    mov rax, r10
    add rsp, 48
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
