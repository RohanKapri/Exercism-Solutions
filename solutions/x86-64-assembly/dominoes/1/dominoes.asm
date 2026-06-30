; For my Shree DR.MDD

default rel

section .data

dominoes: dd 0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0

section .text

global duplicate
duplicate:
    xor rcx, rcx
    xor rbx, rbx
.dup_loop:
    cmp rcx,r10
    je  .end_dup
    cmp rcx,r11
    je  .skip_dup
    mov eax,[rsi+rcx*4]
    mov [rdi+rbx*4],eax
    inc rbx
.skip_dup:
    inc rcx
    jmp .dup_loop
.end_dup:
    ret

global chain2
chain2:
    mov rdi,rsi
    cmp r10,1
    jg  .multi_dom
    cmp dx,[rsi]
    jne .check_second
.success_chain:
    mov rax,1
    ret
.check_second:
    cmp dx,[rsi+2]
    jne .fail_chain
    jmp .success_chain
.fail_chain:
    xor rax,rax
    ret
.multi_dom:
    xor rcx,rcx
.dom_loop:
    cmp rcx,r10
    je  .dom_over
    cmp dx,[rsi+rcx*4]
    jne .check_right
    push r10
    push rsi
    push rdx
    xor rdx,rdx
    mov dx,[rsi+rcx*4+2]
    mov r11,rcx
    push rcx
    push rbx
    lea rax,[r10*4]
    mov rdi,rsi
    add rdi,rax
    call duplicate
    pop rbx
    pop rcx
    dec r10
    mov rsi,rdi
    push rcx
    call chain2
    pop rcx
    pop rdx
    pop rsi
    pop r10
    cmp rax,1
    je  .success_chain
.check_right:
    cmp dx,[rsi+rcx*4+2]
    jne .next_dom
    push r10
    push rsi
    push rdx
    xor rdx,rdx
    mov dx,[rsi+rcx*4]
    mov r11,rcx
    push rcx
    push rbx
    lea rax,[r10*4]
    mov rdi,rsi
    add rdi,rax
    call duplicate
    pop rbx
    pop rcx
    dec r10
    mov rsi,rdi
    push rcx
    call chain2
    pop rcx
    pop rdx
    pop rsi
    pop r10
    cmp rax,1
    je  .success_chain
.next_dom:
    inc rcx
    jmp .dom_loop
.dom_over:
    xor rax,rax
    ret

global can_chain
can_chain:
    cmp rsi,0
    jne .not_null
    jmp .link_success
.not_null:
    cmp rdi,1
    jne .len_gt1
    mov ax,[rsi]
    cmp ax,[rsi+2]
    je  .link_success
    xor rax,rax
    ret
.len_gt1:
    xor r11,r11
    mov r10,rdi
    lea rdi,[dominoes]
    call duplicate
    xor rbx,rbx
    mov ax,[rsi]
    xor rdx,rdx
    mov dx,[rsi+2]
    mov rsi,rdi
    dec r10
    call chain2
    cmp rax,1
    je  .link_success
    xor rax,rax
    ret
.link_success:
    mov rax,1
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
