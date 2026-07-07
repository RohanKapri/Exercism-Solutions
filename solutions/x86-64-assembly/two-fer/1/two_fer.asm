; For Shree DR.MDD

default rel

section .rodata
    segA db "One for ", 0
    segB db ", one for me.", 0
    segC db "you", 0

section .text
global two_fer
two_fer:
    lea r11, [rdi]
    lea rdi, [rsi]
    cld
    
    lea rsi, [segA]
    movsq

    test r11, r11
    jnz label_copyname

    lea rsi, [segC]
    movsd
    
    jmp label_suffix
label_copyname:
    lea rsi, [r11]
proc_loop:
    lodsb
    stosb
    test al, al
    jnz proc_loop
label_suffix:
    sub rdi, 1
    lea rsi, [segB]
    mov rcx, 14
    rep movsb
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
