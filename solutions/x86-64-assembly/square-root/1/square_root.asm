section .text
global square_root
square_root:
    cvtsi2sd xmm0, rdi
    sqrtsd xmm0, xmm0
    cvtsd2si rax, xmm0
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif