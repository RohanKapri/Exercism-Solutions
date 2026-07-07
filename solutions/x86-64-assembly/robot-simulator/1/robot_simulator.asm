section .data

dt: dd 0, 1, 1, 0, 0, -1, -1, 0
tb: dq A, R, 0, L, 0, 0, 0, end

section .text
global create
global move

create:
    mov eax, edi
    shl rsi, 32
    or rax, rsi   
    ret

move:
    lea r10, [rel dt]
    lea r11, [rel tb]
next:
    lodsb
    sub al, 'A'
    and rax, 7
    jmp qword [r11 + 8*rax]
A:
    mov ecx, dword [rdi + 8]
    vmovq xmm0, qword [rdi]
    vpaddd xmm0, [r10 + 8*rcx]
    vmovq qword [rdi], xmm0
    jmp next
L:
    dec dword [rdi + 8]
    and dword [rdi + 8], 3
    jmp next
R:
    inc dword [rdi + 8]
    and dword [rdi + 8], 3
    jmp next
end:
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif