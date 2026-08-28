.text
.globl drinks_water
.globl owns_zebra

.equ NATIONALITIES, 8
.equ ENGLISHMAN, 9
.equ JAPANESE, 10 
.equ NORWEGIAN, 11 
.equ SPANIARD, 12 
.equ UKRAINIAN, 13 

.equ COLORS, 16
.equ BLUE, 17 
.equ GREEN, 18 
.equ IVORY, 19 
.equ RED, 20 
.equ YELLOW, 21 

.equ DRINKS, 24
.equ COFFEE, 25 
.equ MILK, 26 
.equ ORANGE_JUICE, 27 
.equ TEA, 28 
.equ WATER, 29 

.equ HOBBIES, 32
.equ READING, 33 
.equ PAINTING, 34 
.equ FOOTBALL, 35 
.equ DANCING, 36 
.equ CHESS, 37 

.equ PETS, 40
.equ DOG, 41 
.equ FOX, 42 
.equ HORSE, 43 
.equ SNAILS, 44 
.equ ZEBRA, 45 

.equ DRINKS_WATER, 0
.equ OWNS_ZEBRA, 1


next_permutation:
        add x9, x0, 5
        add x10, x0, 6
        ldrb w12, [x9]

.loop1:
        mov w13, w12
        add x9, x9, -1
        ldrb w12, [x9]
        cmp w12, w13
        bge .loop1

.loop2:
        add x10, x10, -1
        ldrb w13, [x10]
        cmp w12, w13
        bge .loop2

        strb w12, [x10]
        strb w13, [x9]
        add x9, x9, 1
        add x10, x0, 5
        cmp x10, x9
        bls .done

.loop3:
        ldrb w12, [x9]
        ldrb w13, [x10]
        strb w12, [x10]
        strb w13, [x9]
        add x9, x9, 1
        add x10, x10, -1
        cmp x10, x9
        bhi .loop3

.done:
        ret



/*
10. The Norwegian lives in the first house.
*/
valid_nationalities:
        ldrb    w9, [x0, NORWEGIAN]
        cmp     w9, 1
        cset    w0, eq
        ret


/*
2. The Englishman lives in the red house.
6. The green house is immediately to the right of the ivory house.
15. The Norwegian lives next to the blue house.
*/
valid_colors:
        ldrb    w10, [x0, ENGLISHMAN]
        ldrb    w11, [x0, RED]
        cmp     w10, w11
        bne     .invalid_colors

        ldrb    w10, [x0, GREEN]
        ldrb    w11, [x0, IVORY]
        add     w11, w11, 1
        cmp     w10, w11
        bne     .invalid_colors

        ldrb    w10, [x0, NORWEGIAN]
        ldrb    w11, [x0, BLUE]
        sub     w10, w10, w11 /* -1 or 1 if adjacent */
        add     w10, w10, 1 /* 0 or 2 if adjacent */
        and     w10, w10, -3 /* clear 2 bit */
        cbnz    w10, .invalid_colors

        mov     w0, 1
        ret

.invalid_colors:
        mov     w0, 0
        ret


/*
4. Coffee is drunk in the green house.
5. The Ukrainian drinks tea.
9. Milk is drunk in the middle house.
*/
valid_drinks:
        ldrb    w10, [x0, COFFEE]
        ldrb    w11, [x0, GREEN]
        cmp     w10, w11
        bne     .invalid_drinks

        ldrb    w10, [x0, UKRAINIAN]
        ldrb    w11, [x0, TEA]
        cmp     w10, w11
        bne     .invalid_drinks

        ldrb    w10, [x0, MILK]
        mov     w11, 3
        cmp     w10, w11
        bne     .invalid_drinks

        mov     w0, 1
        ret

.invalid_drinks:
        mov     w0, 0
        ret


/*
8. The person in the yellow house is a painter.
13. The person who plays football drinks orange juice.
14. The Japanese person plays chess.
*/
valid_hobbies:
        ldrb    w10, [x0, PAINTING]
        ldrb    w11, [x0, YELLOW]
        cmp     w10, w11
        bne     .invalid_hobbies

        ldrb    w10, [x0, FOOTBALL]
        ldrb    w11, [x0, ORANGE_JUICE]
        cmp     w10, w11
        bne     .invalid_hobbies

        ldrb    w10, [x0, JAPANESE]
        ldrb    w11, [x0, CHESS]
        cmp     w10, w11
        bne     .invalid_hobbies

        mov     w0, 1
        ret

.invalid_hobbies:
        mov     w0, 0
        ret


/*
3. The Spaniard owns the dog.
7. The snail owner likes to go dancing.
11. The person who enjoys reading lives in the house next to the person with the fox.
12. The painter's house is next to the house with the horse.
*/
valid_pets:
        ldrb    w10, [x0, SPANIARD]
        ldrb    w11, [x0, DOG]
        add     w11, w11, 1
        cmp     w10, w11
        bne     .invalid_pets

        ldrb    w10, [x0, DANCING]
        ldrb    w11, [x0, SNAILS]
        add     w11, w11, 1
        cmp     w10, w11
        bne     .invalid_pets

        ldrb    w10, [x0, READING]
        ldrb    w11, [x0, FOX]
        sub     w10, w10, w11 /* -1 or 1 if adjacent */
        add     w10, w10, 1 /* 0 or 2 if adjacent */
        and     w10, w10, -3 /* clear 2 bit */
        cbnz    w10, .invalid_pets

        ldrb    w10, [x0, PAINTING]
        ldrb    w11, [x0, HORSE]
        sub     w10, w10, w11 /* -1 or 1 if adjacent */
        add     w10, w10, 1 /* 0 or 2 if adjacent */
        and     w10, w10, -3 /* clear 2 bit */
        cbnz    w10, .invalid_pets

        mov     w0, 1
        ret

.invalid_pets:
        mov     w0, 0
        ret


answer:
        add     sp, sp, -96
        stp     x20, x21, [sp, 48]
        stp     x22, x23, [sp, 64]
        stp     x24, lr, [sp, 80]
        mov     x22, sp
        mov     w23, w0 /* DRINKS_WATER or OWNS_ZEBRA */
        ldr     x24, =0x050403020100

        str     x24, [x22, NATIONALITIES]
.consider_nationalities:
        mov     x0, x22
        bl      valid_nationalities
        cbz     w0, .next_nationalities

        str     x24, [x22, COLORS]
.consider_colors:
        mov     x0, x22
        bl      valid_colors
        cbz     w0, .next_colors

        str     x24, [x22, DRINKS]
.consider_drinks:
        mov     x0, x22
        bl      valid_drinks
        cbz     w0, .next_drinks

        str     x24, [x22, HOBBIES]
.consider_hobbies:
        mov     x0, x22
        bl      valid_hobbies
        cbz     w0, .next_hobbies

        str     x24, [x22, PETS]
.consider_pets:
        mov     x0, x22
        bl      valid_pets
        cbz     w0, .next_pets

        mov     x0, x22

        ldrb    w10, [x0, WATER]
        ldrb    w11, [x0, ZEBRA]
        cmp     w23, OWNS_ZEBRA
        csel    w10, w11, w10, eq

        mov     w9, 'E'
        ldrb    w11, [x0, ENGLISHMAN]
        cmp     w10, w11
        beq     .return

        mov     w9, 'J'
        ldrb    w11, [x0, JAPANESE]
        cmp     w10, w11
        beq     .return

        mov     w9, 'N'
        ldrb    w11, [x0, NORWEGIAN]
        cmp     w10, w11
        beq     .return

        mov     w9, 'S'
        ldrb    w11, [x0, SPANIARD]
        cmp     w10, w11
        beq     .return

        mov     w9, 'U'
        ldrb    w11, [x0, UKRAINIAN]
        cmp     w10, w11
        beq     .return

.next_pets:
        add     x0, x22, PETS
        bl      next_permutation
        ldrb    w10, [x22, PETS]
        cbz     w10, .consider_pets

.next_hobbies:
        add     x0, x22, HOBBIES
        bl      next_permutation
        ldrb    w10, [x22, HOBBIES]
        cbz     w10, .consider_hobbies

.next_drinks:
        add     x0, x22, DRINKS
        bl      next_permutation
        ldrb    w10, [x22, DRINKS]
        cbz     w10, .consider_drinks

.next_colors:
        add     x0, x22, COLORS
        bl      next_permutation
        ldrb    w10, [x22, COLORS]
        cbz     w10, .consider_colors

.next_nationalities:
        add     x0, x22, NATIONALITIES
        bl      next_permutation
        ldrb    w10, [x22, NATIONALITIES]
        cbz     w10, .consider_nationalities

        mov     w9, '?'

.return:
        ldp     x20, x21, [sp, 48]
        ldp     x22, x23, [sp, 64]
        ldp     x24, lr, [sp, 80]
        add     sp, sp, 96
        mov     w0, w9
        ret


drinks_water:
        mov     x0, DRINKS_WATER
        b       answer


owns_zebra:
        mov     x0, OWNS_ZEBRA
        b       answer