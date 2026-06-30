; For Shree DR.MDD

default rel

section .rodata
clvr: db "clover",0
grss: db "grass",0
rds: db "radishes",0
vlts: db "violets",0
sep: db ", ",0

section .data
plants_tbl:
dq 0
dq 0
dq clvr
dq 0
dq 0
dq 0
dq grss
dq 0
dq 0
dq 0
dq 0
dq 0
dq 0
dq 0
dq 0
dq 0
dq 0
dq rds
dq 0
dq 0
dq 0
dq vlts
dq 0
dq 0
dq 0
dq 0

section .text
global plants

plants:
    cld
    push rbx
    xor rcx, rcx
    mov r8, rsi
    lea r10, [plants_tbl]

.scan_garden:
    lodsb
    test al, al
    jnz .scan_garden

    mov r9, rsi
    sub r9, r8
    inc r9
    shr r9,1

    xor rbx, rbx
    mov bl, byte [rdx]
    sub bl,'A'
    shl bl,1
    call .print_plant
    call .print_sep

    inc bl
    call .print_plant
    call .print_sep

    dec bl
    add rbx,r9
    call .print_plant
    call .print_sep

    inc bl
    call .print_plant
    pop rbx
    ret

.print_plant:
    mov cl, byte [r8 + rbx]
    sub cl,'A'
    mov rsi,qword [r10 + 8*rcx]

.copy_str:
    lodsb
    stosb
    test al,al
    jnz .copy_str

    dec rdi
    ret

.print_sep:
    lea rsi,[sep]
    jmp .copy_str

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
