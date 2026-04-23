.data
vowels:
        .byte 1,0,0,0,1,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,1,0

.text
.globl translate

translate:
        mov     w7, #'a'
        mov     w8, #'y'
        adrp    x9, vowels
        add     x9, x9, :lo12:vowels
        sub     x9, x9, x7

start_word:
        mov     x10, x1
        ldrb    w4, [x1]
        cbz     w4, return

        ldrb    w5, [x1, #1]
        ldrb    w6, [x9, x4]
        cbnz    w6, check_yt

check_xr:
        cmp     w4, #'x'
        bne     consonant
        cmp     w5, 'r'
        bne     consonant
        b       vowel

check_yt:
        cmp     w4, #'y'
        bne     vowel
        cmp     w5, #'t'
        beq     vowel

consonant:
        mov     w3, w4
        ldrb    w4, [x10, #1]!
        cmp     w4, w7
        blt     vowel
        ldrb    w6, [x9, x4]
        cbz     w6, consonant
        cmp     w4, #'u'
        bne     vowel
        cmp     w3, #'q'
        bne     vowel
        add     x10, x10, #1

vowel:
        mov     x11, x10
        b       check_for_remaining_letters

copy_remaining_letters:
        add     x11, x11, #1
        strb    w4, [x0], #1

check_for_remaining_letters:
        ldrb    w4, [x11]
        cmp     w4, w7
        bge     copy_remaining_letters
        b       check_for_leading_consonants

copy_leading_consonants:
        ldrb    w5, [x1], #1
        strb    w5, [x0], #1

check_for_leading_consonants:
        cmp     x1, x10
        bne     copy_leading_consonants
        strb    w7, [x0], #1
        strb    w8, [x0], #1
        cbz     w4, return
        strb    w4, [x0], #1
        add     x1, x11, #1
        b       start_word

return:
        strb    wzr, [x0]
        ret
