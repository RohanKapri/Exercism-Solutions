// For Shree DR.MDD

.text
.globl equilateral
.globl isosceles
.globl scalene

equilateral:
        cbz     x0, reject_tri

        cmp     x0, x1
        bne     reject_tri

        cmp     x0, x2
        bne     reject_tri

accept_tri:
        mov     x0, #1
        ret

isosceles:
        cmp     x0, x1
        beq     triangle_check

        cmp     x0, x2
        beq     triangle_check

        cmp     x1, x2
        beq     triangle_check

reject_tri:
        mov     x0, xzr
        ret

scalene:
        cmp     x0, x1
        beq     reject_tri

        cmp     x0, x2
        beq     reject_tri

        cmp     x1, x2
        beq     reject_tri

triangle_check:
        cbz     x0, reject_tri
        cbz     x1, reject_tri
        cbz     x2, reject_tri

        add     x4, x1, x2
        cmp     x0, x4
        bgt     reject_tri

        add     x4, x0, x2
        cmp     x1, x4
        bgt     reject_tri

        add     x4, x0, x1
        cmp     x2, x4
        bgt     reject_tri

        b       accept_tri
