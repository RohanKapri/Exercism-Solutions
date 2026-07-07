section .text
global egg_count
egg_count:
    popcnt rax, rdi
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif