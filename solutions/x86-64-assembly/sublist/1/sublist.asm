section .text
global sublist

sublist:
    xor eax, eax
    cmp rsi, rcx
    jz .check_equal
    jb .check_sublist

    xchg rdi, rdx
    xchg rsi, rcx
    call sublist
    
    mov ecx, eax
    shr ecx, 1
    or eax, ecx  ; 2 becomes 3 and 0 stays 0
    ret

.check_sublist:    
    mov r9, rdi
    mov r10, rcx
    sub r10, rsi
    inc r10
    mov r11, rsi
.loop_sublist:
    test r10, r10
    jz .end_sublist

    dec r10

    mov rcx, r11
    mov rsi, r9
    lea rdi, [rdx + 8*r10]
    repe cmpsq
    jnz .loop_sublist
    
    or eax, 2
.end_sublist:
    ret

.check_equal:
    test rsi, rsi
    jz .equal

    mov rsi, rdx
    repe cmpsq
.equal:
    setz al
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc nowrite progbits
%endif