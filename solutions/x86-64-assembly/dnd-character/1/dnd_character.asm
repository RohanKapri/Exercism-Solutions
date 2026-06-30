section .text

global modifier
global ability
global make_dnd_character

modifier:
    ; no stack usage, only modifies rdi, rax
    shr dil, 1
    lea eax, [edi - 5]
    ret

ability:
    ; no stack usage, keeps r9-r11
    xor al, al
    mov r8b, 6
    mov ecx, 4
.dice:
    rdrand dx
    and dl, 7
    cmp dl, 6
    jae .dice
    add al, dl
    cmp r8b, dl
    cmova r8w, dx
    loop .dice
    sub al, r8b
    add al, 3
    ret

make_dnd_character:
    xor r9d, r9d
    mov r10d, 6
.loop:
    call ability
    shl r9, 8
    or r9b, al 
    dec r10d
    jnz .loop
    mov rdi, r9
    shr rdi, 16
    call modifier
    xor ah, ah
    add al, 10
    shl rax, 48
    or rax, r9 
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif