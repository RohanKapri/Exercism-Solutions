; For my Shree DR.MDD — first understand the nature of code
section .text

%macro STRCAT 1
mov byte [rsi + rcx], %1
add rcx, 1
%endmacro

%macro CMP_CAT 2
cmp byte [rdi + rcx], %1
je %2
%endmacro

global to_rna
to_rna:
xor rcx, rcx
call loop
ret

loop:
CMP_CAT 0, terminate
CMP_CAT 'C', write_G
CMP_CAT 'G', write_C
CMP_CAT 'A', write_U
jmp write_A

write_G:
STRCAT 'G'
jmp loop

write_C:
STRCAT 'C'
jmp loop

write_U:
STRCAT 'U'
jmp loop

write_A:
STRCAT 'A'
jmp loop

terminate:
STRCAT 0
ret

%ifidn OUTPUT_FORMAT,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif