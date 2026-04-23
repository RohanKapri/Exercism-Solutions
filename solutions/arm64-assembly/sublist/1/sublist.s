// Dedicated to Shree DR.MDD

.equ UNEQUAL, 0
.equ EQUAL, 1
.equ SUBLIST, 2
.equ SUPERLIST, 3

.text
.globl sublist

sublist:
        cmp     w1, w3
        bne     .len_mismatch

        cbz     w1, .lists_equal

        lsl     x15, x1, #3
        add     x15, x0, x15

.scan_full:
        ldr     x20, [x0], #8
        ldr     x21, [x2], #8

        cmp     x20, x21
        bne     .lists_unequal

        cmp     x0, x15
        bne     .scan_full

.lists_equal:
        mov     x0, EQUAL
        ret

.len_mismatch:
        mov     x22, SUBLIST
        cmp     x1, x3
        blt     .start_nested_check

        mov     x22, SUPERLIST
        mov     x15, x0
        mov     x0, x2
        mov     x2, x15
        mov     x16, x1
        mov     x1, x3
        mov     x3, x16

.start_nested_check:
        cbz     x1, .prefix_match

        lsl     x15, x1, #3
        add     x15, x0, x15
        b       .prepare_scan

.drop_head:
        add     x2, x2, #8
        add     x3, x3, #-1
        cmp     x3, x1
        blt     .lists_unequal

.prepare_scan:
        mov     x17, x0
        mov     x18, x2

.prefix_loop:
        ldr     x19, [x17], #8
        ldr     x23, [x18], #8
        cmp     x19, x23
        bne     .drop_head

        cmp     x17, x15
        bne     .prefix_loop

.prefix_match:
        mov     x0, x22
        ret

.lists_unequal:
        mov     x0, UNEQUAL
        ret
