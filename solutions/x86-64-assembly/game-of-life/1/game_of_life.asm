; For my Shree DR.MDD


section .text
global tick

tick:
        push    rbx
        push    r12
        push    r13
        push    r14
        push    r15
        mov     rbx, rcx
        cld

        test    rdx, rdx
        jz      .done

        lodsq
        xor     r11, r11
        mov     r12, rax

.outer:
        xor     r13, r13
        sub     rdx, 1
        jz      .handle_row

        lodsq
        mov     r13, rax

.handle_row:
        xor     rax, rax
        test    rcx, rcx
        jz      .write_row

        xor     r9, r9
        mov     r10, r11
        and     r10, 1
        mov     r15, r13
        and     r15, 1
        add     r10, r15
        mov     r15, r12
        and     r15, 1
        add     r10, r15

.inner:
        ror     r11, 1
        ror     r12, 1
        ror     r13, 1

        mov     r14, r15
        mov     r8, r9
        mov     r9, r10

        mov     r10, r11
        and     r10, 1
        mov     r15, r13
        and     r15, 1
        add     r10, r15
        mov     r15, r12
        and     r15, 1
        add     r10, r15

        add     r8, r9
        add     r8, r10
        sub     r8, r14
        or      r8, r14
        cmp     r8, 3
        jne     .shift_right

        inc     rax

.shift_right:
        ror     rax, 1
        loop    .inner

.write_row:
        mov     rcx, rbx
        rol     rax, cl
        stosq

        rol     r12, cl
        rol     r13, cl
        mov     r11, r12
        mov     r12, r13
        test    rdx, rdx
        jnz     .outer

.done:
        pop     r15
        pop     r14
        pop     r13
        pop     r12
        pop     rbx
        ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
