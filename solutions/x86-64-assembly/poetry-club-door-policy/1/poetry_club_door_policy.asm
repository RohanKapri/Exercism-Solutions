default rel

section .rodata
    polite_request db `, please.`, 0
    polite_request_length equ $ - polite_request

section .text

%macro is_alpha 1
    cmp %1, 'z'
    setbe r11b
    
    cmp %1, 'a'
    setae r10b
    
    and r11b, r10b
    jnz %%yes

    cmp %1, 'Z'
    setbe r11b

    cmp %1, 'A'
    setae r10b

    and r11b, r10b
%%yes:
%endmacro

global front_door_response
front_door_response:
    mov al, byte [rdi]
    ret

global front_door_password
front_door_password:
    cmp byte [rdi], 0
    jz .exit

    xor ax, ax
    mov rsi, rdi
    
    lodsb    
    btr ax, 5
    stosb
.down:
    lodsb 
    
    test al, al
    jz .exit      
    
    bts ax, 5
    stosb
    
    jmp .down
.exit:    
    ret

global back_door_response
back_door_response:
    mov rsi, rdi
    xor rax, rax
.loop:
    lodsb
    
    test al, al
    jz .exit
    
    is_alpha al
    cmovnz rcx, rax

    jmp .loop
.exit:
    mov al, cl
    ret

global back_door_password
back_door_password:
    push rdi
.copy:    
    lodsb
    stosb
    test al, al
    jnz .copy

    pop rdi
    call front_door_password
    
    lea rsi, [polite_request]
    mov rcx, polite_request_length
    rep movsb
    ret
    
%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif