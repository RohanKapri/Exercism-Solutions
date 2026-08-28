; For my Shree DR.MDD
section .text

%macro SQUARE 1
    imul %1, %1
%endmacro

global square_of_sum
global sum_of_squares
global difference_of_squares

accumulate_sum:
    add r8d, 1
    add eax, r8d
    cmp r8d, edi
    jl accumulate_sum
    ret

square_of_sum:
    xor eax, eax
    xor r8d, r8d
    call accumulate_sum
    SQUARE eax
    ret

accumulate_squares:
    add r8d, 1
    mov r9d, r8d
    SQUARE r9d
    add eax, r9d
    cmp r8d, edi
    jl accumulate_squares
    ret

sum_of_squares:
    xor eax, eax
    xor r8d, r8d
    call accumulate_squares
    ret

difference_of_squares:
    call sum_of_squares
    mov r10d, eax
    call square_of_sum
    sub eax, r10d
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
