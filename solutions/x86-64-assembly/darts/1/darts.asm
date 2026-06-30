; For my Shree DR.MDD
default rel

section .rodata
    outer_radius dq 10.0
    mid_radius dq 5.0
    inner_radius dq 1.0

section .text
global score
score:
    ; xmm0 - a double representing x
    ; xmm1 - a double representing y
    ; output is a uint8_t in al

    mulsd xmm0, xmm0
    mulsd xmm1, xmm1
    addsd xmm0, xmm1
    sqrtsd xmm0, xmm0

    xor rax, rax

    movsd xmm2, qword [outer_radius]
    ucomisd xmm0, xmm2
    ja miss_zone

    movsd xmm2, qword [mid_radius]
    ucomisd xmm0, xmm2
    ja zone_outer

    movsd xmm2, qword [inner_radius]
    ucomisd xmm0, xmm2
    ja zone_mid

    add al, 5
zone_mid:
    add al, 4
zone_outer:
    add al, 1
miss_zone:
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
