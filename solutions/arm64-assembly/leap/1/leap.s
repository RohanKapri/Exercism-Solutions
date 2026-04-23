.text
.globl leap_year
leap_year:
    mov    x9, #4
    udiv   x1, x0, x9
    msub   x1, x1, x9, x0
    cbnz   x1, no_leap

    mov    x9, #400
    udiv   x1, x0, x9
    msub   x1, x1, x9, x0
    cbz    x1, leap

    mov    x9, #100
    udiv   x1, x0, x9
    msub   x1, x1, x9, x0
    cbz    x1, no_leap
leap:
    mov    x0, 1
    ret
no_leap:
    mov    x0, 0
    ret