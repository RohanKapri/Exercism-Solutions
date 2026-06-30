section .text
global reverse
reverse:
    call strlen
    mov rbx, rax
    shr rbx, 1
    xor rcx, rcx
    sub rax, 1
    call mk_reversed
    ret

strlen:
    xor rcx, rcx

count:
    cmp byte [rdi + rcx], 0
    je end_count
    add rcx, 1
    jmp count

end_count:
    mov rax, rcx
    ret

mk_reversed:
    cmp rcx, rbx
    jge end_reverse
    
    mov byte dl, [rdi + rcx]
    mov byte dh, [rdi + rax]
    mov byte [rdi + rcx], dh
    mov byte [rdi + rax], dl
    add rcx, 1
    sub rax, 1
    jmp mk_reversed
    
end_reverse:
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif