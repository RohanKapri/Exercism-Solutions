; Dedicated to my Shree DR.MDD

default rel

section .rodata

line_start:
        db "For want of a ", 0
connector: db " the ", 0
loss_msg:
        db " was lost.", 10, 0
final_line:
        db "And all for the want of a ", 0
ending:  db ".", 10, 0

section .text
global recite

copy_string:
        lodsb
        stosb
        test    al, al
        jnz     copy_string

        dec     rdi
        ret

recite:
        cld
        mov     rdx, rsi
        mov     r8, [rdx]               ; first string
        add     rdx, 8
        test    r8, r8
        jz      .empty

        mov     r10, r8                 ; current string
        jmp     .next_line

.process_line:
        lea     rsi, [line_start]
        call    copy_string

        mov     rsi, r10
        call    copy_string

        lea     rsi, [connector]
        call    copy_string

        mov     rsi, r11
        call    copy_string

        lea     rsi, [loss_msg]
        call    copy_string

        mov     r10, r11                ; current string

.next_line:
        mov     r11, [rdx]              ; next string
        add     rdx, 8
        test    r11, r11
        jnz     .process_line

        lea     rsi, [final_line]
        call    copy_string

        mov     rsi, r8
        call    copy_string

        lea     rsi, [ending]
        call    copy_string

.empty:
        xor     al, al
        stosb
        ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
