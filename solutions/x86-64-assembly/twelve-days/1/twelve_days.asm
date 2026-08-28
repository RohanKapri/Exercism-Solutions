; Dedicated to my Shree DR.MDD

default rel

section .rodata

start_line: db "On the ", 0
verse_line: db " day of Christmas my true love gave to me: ", 0
all_gifts: db "twelve Drummers Drumming, eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.", 10, 0

gift_offsets:
        dq 0
        dq 235
        dq 213
        dq 194
        dq 174
        dq 157
        dq 137
        dq 113
        dq 90
        dq 69
        dq 48
        dq 26
        dq 0

one_day: db "first", 0
two_day: db "second", 0
three_day: db "third", 0
four_day: db "fourth", 0
five_day: db "fifth", 0
six_day: db "sixth", 0
seven_day: db "seventh", 0
eight_day: db "eighth", 0
nine_day: db "ninth", 0
ten_day: db "tenth", 0
eleven_day: db "eleventh", 0
twelve_day: db "twelfth", 0

section .data

verse_ordinals:
        dq 0
        dq one_day
        dq two_day
        dq three_day
        dq four_day
        dq five_day
        dq six_day
        dq seven_day
        dq eight_day
        dq nine_day
        dq ten_day
        dq eleven_day
        dq twelve_day

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
        lea     r8, [verse_ordinals]
        lea     r9, [gift_offsets]
        mov     r10, rsi

.next_verse:
        lea     rsi, [start_line]
        call    copy_string

        mov     rsi, [r8 + r10*8]
        call    copy_string

        lea     rsi, [verse_line]
        call    copy_string

        mov     r11, [r9 + r10*8]
        lea     rsi, [all_gifts]
        add     rsi, r11
        call    copy_string

        inc r10
        cmp r10, rdx
        jle .next_verse

        ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
