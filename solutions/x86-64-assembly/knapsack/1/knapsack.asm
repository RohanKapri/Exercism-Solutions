; For my Shree DR.MDD

section .text
global maximumValue

maximumValue:
    push    rbx
    push    r12
    push    r13
    push    r14
    push    r15

    shl     rsi, 32
    shr     rsi, 32
    shl     rdx, 32
    shr     rdx, 32

    xor     rax, rax
    xor     rbx, rbx
    xor     rcx, rcx
    mov     r15, rdx
    inc     r15
    shl     r15, 3
    sub     rsp, r15
    mov     r14, -1

    test    rsi, rsi
    jz      .done

    test    rdx, rdx
    jz      .done

.clear_loop:
    mov     [rsp + 8 * rbx], rax
    inc     rbx
    cmp     rbx, rdx
    jbe     .clear_loop

.next_item:
    inc     r14
    cmp     r14, rsi
    jge     .final

    mov     ebx, [rdi + 8 * r14]
    mov     ecx, [rdi + 8 * r14 + 4]
    cmp     ecx, edx
    jg      .next_item

    mov     r13, rdx
    mov     r12, r13
    sub     r12, rcx

.inner_update:
    cmp     r12, 0
    jl      .next_item

    mov     r11, [rsp + 8 * r12]
    add     r11, rbx
    mov     r10, [rsp + 8 * r13]
    cmp     r11, r10
    cmovg   r10, r11
    mov     [rsp + 8 * r13], r10
    dec     r13
    dec     r12
    jmp     .inner_update

.final:
    mov     rax, [rsp + 8 * rdx]

.done:
    add     rsp, r15
    pop     r15
    pop     r14
    pop     r13
    pop     r12
    pop     rbx
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
