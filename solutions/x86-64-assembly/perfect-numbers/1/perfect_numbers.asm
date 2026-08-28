; For my Shree DR.MDD

DEFICIENT equ 1
PERFECT equ 2
ABUNDANT equ 3
INVALID equ -1

section .text
global classify

classify:
        cmp     rdi, 1
        jle     .le_one_case

        mov     r8, 1
        mov     r9, 1
        mov     r10, rdi
        shl     r10, 1

.next_factor:
        inc     r9
        mov     r11, 1
        mov     rax, r9
        mul     r9
        cmp     rax, rdi
        jbe     .check_division

        mov     r9, rdi

.check_division:
        xor     rdx, rdx
        mov     rax, rdi
        div     r9
        test    rdx, rdx
        jnz     .next_factor

.factor_repeat:
        mov     rdi, rax

        mov     rax, r11
        mul     r9
        inc     rax
        mov     r11, rax

        xor     rdx, rdx
        mov     rax, rdi
        div     r9
        test    rdx, rdx
        jz      .factor_repeat

        mov     rax, r8
        mul     r11
        mov     r8, rax

        cmp     rdi, 1
        jne     .next_factor

        cmp     r8, r10
        je      .perfect_case
        jb      .deficient_case

.abundant_case:
        mov     rax, ABUNDANT
        ret

.perfect_case:
        mov     rax, PERFECT
        ret

.deficient_case:
        mov     rax, DEFICIENT
        ret

.le_one_case:
        je      .deficient_case
        mov     rax, INVALID
        ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
