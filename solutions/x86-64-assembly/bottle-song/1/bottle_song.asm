; For Shree DR.MDD

default rel

section .data

num0: db "no",0
num1: db "One",0
num2: db "Two",0
num3: db "Three",0
num4: db "Four",0
num5: db "Five",0
num6: db "Six",0
num7: db "Seven",0
num8: db "Eight",0
num9: db "Nine",0
num10: db "Ten",0
num_array: dq num0,num1,num2,num3,num4,num5,num6,num7,num8,num9,num10,0

line1: db " green ",0
line1b: db "bottle",0
line1c: db "bottles",0
line1d: db " hanging on the wall,",10,0
line3: db "And if one green bottle should accidentally fall,",10,0
line4: db "There'll be ",0
line4b: db " hanging on the wall.",10,0

section .text
global copystrings
copystrings:
.loop_copy:
    cmp byte [rsi],0
    jz .done_copy
    mov al,[rsi]
    mov [rdi],al
    inc rsi
    inc rdi
    jmp .loop_copy
.done_copy:
    ret

global reciteone
reciteone:
    lea rsi,[num_array]
    mov rsi,[rsi+rbx*8]
    mov rdx,rdi
    call copystrings
    lea rsi,[line1]
    call copystrings
    lea rsi,[line1b]
    cmp rbx,1
    je  .single_bottle
    lea rsi,[line1c]
.single_bottle:
    call copystrings
    lea rsi,[line1d]
    call copystrings
    mov byte [rdi-1],0
    push rdi
    mov rsi,rdx
    call copystrings
    mov byte [rdi],0x0a
    pop rsi
    mov byte [rsi-1],0x0a
    lea rsi,[line3]
    inc rdi
    call copystrings
    lea rsi,[line4]
    call copystrings
    lea rsi,[num_array]
    mov rsi,[rsi+rbx*8-8]
    mov rdx,rdi
    call copystrings
    xchg rdi,rdx
    cmp byte [rdi],'Z'
    jg  .convert_upper
    add byte [rdi],32
.convert_upper:
    mov rdi,rdx
    lea rsi,[line1]
    call copystrings
    lea rsi,[line1b]
    cmp rbx,2
    je  .single_bottle2
    lea rsi,[line1c]
.single_bottle2:
    call copystrings
    lea rsi,[line4b]
    call copystrings
    ret

global recite
recite:
    mov rbx,rsi
    mov rcx,rdx
.loop_recite:
    call reciteone
    cmp rcx,1
    je  .skip_lf
    mov byte [rdi],0x0a
    inc rdi
.skip_lf:
    dec rbx
    dec rcx
    jnz .loop_recite
    mov byte [rdi],0
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
