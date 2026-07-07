; For Shree DR.MDD

section .text
global value
value:
    cld
    call pick_color
    mov r8, rax

    mov rsi, rdi
    call pick_color

    mov r10, 10
    mul r10
    add rax, r8
    ret

pick_color:
    xor rax, rax
    lodsb
    or al, 0x20
    cmp al, 'r'
    je .red_lbl

    cmp al, 'o'
    je .orange_lbl

    cmp al, 'y'
    je .yellow_lbl

    cmp al, 'v'
    je .violet_lbl

    cmp al, 'w'
    je .white_lbl

    mov dl, al
    add rsi, 2
    lodsb
    or al, 0x20
    cmp dl, 'g'
    je .green_grey_lbl

.black_brown_blue_lbl:
    cmp al, 'w'
    je .brown_lbl

    cmp al, 'e'
    je .blue_lbl

.black_lbl:
    mov al, 0
    ret

.brown_lbl:
    mov al, 1
    ret

.red_lbl:
    mov al, 2
    ret

.orange_lbl:
    mov al, 3
    ret

.yellow_lbl:
    mov al, 4
    ret

.green_grey_lbl:
    cmp al, 'y'
    je .grey_lbl

.green_lbl:
    mov al, 5
    ret

.blue_lbl:
    mov al, 6
    ret

.violet_lbl:
    mov al, 7
    ret

.grey_lbl:
    mov al, 8
    ret

.white_lbl:
    mov al, 9
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
