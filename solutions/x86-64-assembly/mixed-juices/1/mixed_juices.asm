section .rodata
    juice_times dd 1, 3, 3, 4, 5, 4, 7, 10

section .text

global time_to_make_juice
global time_to_prepare
global limes_to_cut
global remaining_orders

time_to_make_juice:
    lea rsi, [rel juice_times]
    mov eax, dword [rsi + 4*rdi - 4]
    ret

time_to_prepare:
    xor eax, eax
    mov ecx, esi
    lea rsi, [rel juice_times]
.accum:
    mov edx, dword [rdi + 4*rcx - 4]
    add eax, dword [rsi + 4*rdx - 4]
    dec rcx
    jnz .accum
    ret

limes_to_cut:
    xor eax, eax
.loop:
    cmp eax, edx
    je .exit

    mov r8d, 6
    mov r9d, 8
    mov r10d, 10
    
    cmp byte [rsi + rax], 'M'
    cmovl r9d, r10d
    cmovg r9d, r8d

    inc eax
    sub edi, r9d
    jg .loop
.exit:    
    ret

remaining_orders:
    xor eax, eax
    lea rcx, [rel juice_times]
.accum:
    mov edx, dword [rsi + 4*rax]
    inc eax
    sub edi, dword [rcx + 4*rdx - 4]
    jg .accum
    ret
    
%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif