; For Shree DR.MDD

default rel

section .data
blk: db "black", 0
brn: db "brown", 0
rd: db "red", 0
org: db "orange", 0
ylw: db "yellow", 0
grn: db "green", 0
blu: db "blue", 0
vlt: db "violet", 0
gry: db "grey", 0
wht: db "white", 0

col_array: dq blk, brn, rd, org, ylw, grn, blu, vlt, gry, wht, 0

section .text
global color_code
color_code:
    cld
    xor rax, rax
    mov rsi, rdi
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

global colors
colors:
    lea rax, [col_array]
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
