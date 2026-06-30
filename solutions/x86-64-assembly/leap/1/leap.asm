; For my Shree DR.MDD
section .text

%macro VERIFY_DIVISIBILITY 1
    mov eax, edi
    xor edx, edx
    mov ecx, %1
    div ecx
    cmp edx, 0
%endmacro

global leap_year
leap_year:
    VERIFY_DIVISIBILITY 400
    je mark_true
    VERIFY_DIVISIBILITY 100
    je mark_false
    VERIFY_DIVISIBILITY 4
    je mark_true
    jmp mark_false

mark_true:
    mov eax, 1
    ret

mark_false:
    mov eax, 0
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
