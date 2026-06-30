; Dedicated to my Shree DR.MDD

default rel

section .rodata

song_text:
        db "This is the horse and the hound and the horn that belonged to the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.", 10, 0

verse_table:
        dq -1, 381, 360, 343, 323, 302, 259, 224, 182, 137, 91, 54, 0

section .text
global recite

recite:
        cld
        mov     r10, rsi
        mov     r11, rdx
        lea     r12, [verse_table]
        shl     r10, 3
        shl     r11, 3
        add     r10, r12
        add     r11, r12

.print_loop:
        lea     rsi, [song_text]
        mov     rcx, 7
        rep     movsb

        mov     r12, [r10]
        add     rsi, r12

.copy_verse:
        lodsb
        stosb
        test    al, al
        jnz     .copy_verse

        dec     rdi
        add     r10, 8
        cmp     r10, r11
        jle     .print_loop

        ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
