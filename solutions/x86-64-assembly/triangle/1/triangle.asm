; For Shree DR.MDD

section .text

global is_equilateral
is_equilateral:
    movsd xmm9, qword [rsp+8]
    movsd xmm8, qword [rsp+16]
    movsd xmm7, qword [rsp+24]
    call shape_chk
    test rax, rax
    jz mark_zero

    comisd xmm9, xmm8
    jne mark_zero
    comisd xmm8, xmm7
    jne mark_zero
    jmp mark_one

global is_isosceles
is_isosceles:
    movsd xmm9, qword [rsp+8]
    movsd xmm8, qword [rsp+16]
    movsd xmm7, qword [rsp+24]
    call shape_chk
    test rax, rax
    jz mark_zero

    comisd xmm9, xmm8
    je mark_one
    comisd xmm8, xmm7
    je mark_one
    comisd xmm7, xmm9
    je mark_one
    jmp mark_zero

global is_scalene
is_scalene:
    movsd xmm9, qword [rsp+8]
    movsd xmm8, qword [rsp+16]
    movsd xmm7, qword [rsp+24]
    call shape_chk
    test rax, rax
    jz mark_zero

    comisd xmm9, xmm8
    je mark_zero
    comisd xmm8, xmm7
    je mark_zero
    comisd xmm7, xmm9
    je mark_zero
    jmp mark_one

shape_chk:
    pxor xmm6, xmm6
    comisd xmm9, xmm6
    jbe mark_zero
    comisd xmm8, xmm6
    jbe mark_zero
    comisd xmm7, xmm6
    jbe mark_zero
    movsd xmm6, xmm9
    addsd xmm6, xmm8
    comisd xmm6, xmm7
    jb mark_zero
    movsd xmm6, xmm8
    addsd xmm6, xmm7
    comisd xmm6, xmm9
    jb mark_zero
    movsd xmm6, xmm9
    addsd xmm6, xmm7
    comisd xmm6, xmm8
    jb mark_zero
    jmp mark_one

mark_zero:
    xor rax, rax
    ret

mark_one:
    mov rax, 1
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
