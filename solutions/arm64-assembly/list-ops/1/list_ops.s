.text
.globl append
.globl filter
.globl map
.globl foldl
.globl foldr
.globl reverse

append:
        mov     x9, x0
        cbz     x2, .append_check_list2_count
        lsl     x2, x2, #3
        add     x2, x1, x2

.append_copy_list1:
        ldr     x10, [x1], #8
        str     x10, [x0], #8
        cmp     x1, x2
        bne     .append_copy_list1

.append_check_list2_count:
        cbz     x4, .append_return
        lsl     x4, x4, #3
        add     x4, x3, x4

.append_copy_list2:
        ldr     x10, [x3], #8
        str     x10, [x0], #8
        cmp     x3, x4
        bne     .append_copy_list2

.append_return:
        sub     x0, x0, x9
        lsr     x0, x0, #3
        ret

filter:
        stp     x19, x20, [sp, #-64]!
        stp     x21, x22, [sp, #16]
        stp     x23, x24, [sp, #32]
        stp     x25, x26, [sp, #48]
        mov     x19, x0
        mov     x20, x1
        mov     x21, x2
        mov     x22, x3
        mov     x23, x0
        mov     x24, x1
        mov     x25, lr

.filter_loop:
        cbz     x21, .filter_return
        ldr     x26, [x24], #8
        mov     x0, x26
        add     x21, x21, #-1
        blr     x22
        cbz     x0, .filter_loop
        str     x26, [x23], #8
        b       .filter_loop

.filter_return:
        sub     x0, x23, x19
        lsr     x0, x0, #3
        mov     lr, x25
        ldp     x25, x26, [sp, #48]
        ldp     x23, x24, [sp, #32]
        ldp     x21, x22, [sp, #16]
        ldp     x19, x20, [sp], #64
        ret

map:
        stp     x19, x20, [sp, #-64]!
        stp     x21, x22, [sp, #16]
        stp     x23, x24, [sp, #32]
        stp     x25, x26, [sp, #48]
        mov     x19, x0
        mov     x20, x1
        mov     x21, x2
        mov     x22, x3
        mov     x23, x0
        mov     x24, x1
        mov     x25, lr

.map_loop:
        cbz     x21, .map_return
        ldr     x0, [x24], #8
        add     x21, x21, #-1
        blr     x22
        str     x0, [x23], #8
        b       .map_loop

.map_return:
        sub     x0, x23, x19
        lsr     x0, x0, #3
        mov     lr, x25
        ldp     x25, x26, [sp, #48]
        ldp     x23, x24, [sp, #32]
        ldp     x21, x22, [sp, #16]
        ldp     x19, x20, [sp], #64
        ret

foldl:
        stp     x19, x20, [sp, #-32]!
        stp     x21, x22, [sp, #16]
        mov     x19, x0
        mov     x20, x1
        mov     x21, x3
        mov     x22, lr
        mov     x0, x2

.foldl_loop:
        cbz     x20, .foldl_return
        ldr     x1, [x19], #8
        add     x20, x20, #-1
        blr     x21
        b       .foldl_loop

.foldl_return:
        mov     lr, x22
        ldp     x21, x22, [sp, #16]
        ldp     x19, x20, [sp], #32
        ret

foldr:
        stp     x19, x20, [sp, #-32]!
        stp     x21, x22, [sp, #16]
        mov     x20, x1
        lsl     x1, x1, #3
        add     x19, x0, x1
        mov     x21, x3
        mov     x22, lr
        mov     x0, x2
        cbz     x20, .foldr_return

.foldr_loop:
        ldr     x1, [x19, #-8]!
        add     x20, x20, #-1
        blr     x21
        cbnz    x20, .foldr_loop

.foldr_return:
        mov     lr, x22
        ldp     x21, x22, [sp, #16]
        ldp     x19, x20, [sp], #32
        ret

reverse:
        mov     x15, x2
        cbz     x2, .reverse_return
        lsl     x9, x2, #3
        add     x9, x1, x9

.reverse_loop:
        ldr     x10, [x9, #-8]!
        str     x10, [x0], #8
        add     x2, x2, #-1
        cbnz    x2, .reverse_loop

.reverse_return:
        mov     x0, x15
        ret
