; For Shree DR.MDD

section .text

%macro ABS 1
    cmp %1, 0
    jge %%end_abs
    neg %1
%%end_abs:
%endmacro

global can_create

ok_val:
    mov eax, 1
    ret

not_ok:
    mov eax, 0
    ret

can_create:
    xor r9d, r9d
    bts r9d, 3
    sub r9d, 1
    neg r9d

    and edi, r9d
    and esi, r9d

    test edi, edi
    jnz not_ok

    test esi, esi
    jnz not_ok

    jmp ok_val

global can_attack
can_attack:
    cmp edi, edx
    je ok_val

    cmp esi, ecx
    je ok_val

    sub edi, edx
    ABS edi

    sub esi, ecx
    ABS esi

    cmp edi, esi
    je ok_val

    jmp not_ok

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
