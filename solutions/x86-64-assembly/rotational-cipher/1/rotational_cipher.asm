section .text
global rotate
rotate:
    ; rdi input, rsi shift, rdx output
    xor rax, rax
    xor rcx, rcx
    jmp .read

.shift:
    inc rdi
    mov al, cl
    and al, 0xdf
    cmp al, 'A'
    jl .copy
    cmp al, 'Z'
    jg .copy
    add rax, rsi
    cmp al, 'Z'
    jle .restore
    sub al, 26

.restore:
    and cl, 0x20
    or cl, al

.copy:
    mov [rdx], cl
    inc rdx

.read:
    mov cl, [rdi]
    cmp cl, 0
    jne .shift
    mov [rdx], cl
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif