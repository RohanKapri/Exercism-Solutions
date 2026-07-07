; For my Shree DR.MDD - first understand the nature of code

section .text
global annotate

annotate:
        push    rbx
        push    rbp
        push    r12
        push    r13
        push    r14
        push    r15
        cld
        mov     rbx, rsi
        mov     al, [rbx]
        test    al, al
        jz      .finish

.scan_newline:
        lodsb
        cmp     al, 0x0a
        jne     .scan_newline

        mov     rdx, rsi
        mov     rsi, rbx
        sub     rdx, rbx

.find_end:
        add     rbx, rdx
        mov     al, [rbx]
        test    al, al
        jnz     .find_end

        mov     rbp, rbx
        mov     r9, rsi
        mov     r10, rsi

.row_loop:
        xor     r13, r13
        xor     r14, r14
        mov     r8, r9
        mov     r9, r10

        mov     r10, r9
        add     r10, rdx
        cmp     r10, rbp
        jne     .col_start
        mov     r10, r9

.col_start:
        cmp     rdx, 1
        je      .newline_write

.col_loop:
        mov     r12, r13
        mov     r13, r14
        mov     rax, r13
        add     r14, 2
        cmp     r14, rdx
        je      .col_update
        inc     rax

.col_update:
        mov     r14, rax
        mov     al, [r9 + r13]
        cmp     al, '*'
        je      .square_write

        xor     rcx, rcx
        mov     r11, r8
        sub     r11, rdx

.adj_row:
        add     r11, rdx
        mov     r15, r12
        dec     r15

.adj_col:
        inc     r15
        mov     al, [r11 + r15]
        cmp     al, '*'
        jne     .adj_next
        inc     rcx

.adj_next:
        cmp     r15, r14
        jne     .adj_col
        cmp     r11, r10
        jne     .adj_row

        mov     al, ' '
        test    rcx, rcx
        jz      .square_write
        mov     al, '0'
        add     al, cl

.square_write:
        stosb
        cmp     r13, r14
        jne     .col_loop

.newline_write:
        mov     al, 0x0a
        stosb
        cmp     r9, r10
        jne     .row_loop

.finish:
        xor     al, al
        stosb
        pop     r15
        pop     r14
        pop     r13
        pop     r12
        pop     rbp
        pop     rbx
        ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
