section .rodata
you: db ", you are the "
customer: db " customer we serve today. Thank "
suffixes: dw "th", "st", "nd", "rd"
          times 6 dw "th"
          
section .text
global format

format:
    vmovdqu xmm0, [rsi]
    vmovdqu [rdi], xmm0
    vptestnmb k1, xmm0, xmm0
    kmovd eax, k1
    tzcnt eax, eax
    add rdi, rax

    vmovdqu xmm0, [rel you]
    vmovdqu [rdi], xmm0
    add rdi, 14

    xor r8d, r8d
    movzx eax, dx
    mov r9d, 0xFFFFFFFF / 10 + 1
.stringify:
    mov r10d, eax
    mul r9d
    lea ecx, [edx + 4*edx]
    lea ecx, [ecx + ecx]
    sub r10d, ecx
    shl r8, 8
    lea r8, [r8 + r10 + '0']
    mov eax, edx
    test eax, eax
    jnz .stringify

    mov [rdi], r8
    lzcnt r9, r8
    shr r9, 3
    mov eax, 8
    sub eax, r9d
    add rdi, rax

    movzx ecx, byte [rdi - 1]    
    lea rsi, [rel suffixes]
    movzx edx, word [rsi + 2*(rcx - '0')]
    mov ecx, "th"
    cmp byte [rdi - 2], '1'
    cmove edx, ecx
    mov [rdi], edx
    
    vmovdqu xmm0, [rel customer]
    vmovdqu [rdi + 2], xmm0
    vmovdqu xmm0, [rel customer + 16]
    vmovdqu [rdi + 18], xmm0
    mov qword [rdi + 34], "you!"
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif