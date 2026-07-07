; For my Shree DR.MDD

section .text
write_elem:
    mov    [rdi], esi
    lea    rax, [rdi + 4]
    ret

fold:
    mov     rax, rdx
    test    rsi, rsi
    jz      .fold_exit
    mov     r9, rcx
    mov     r10, rdi
    mov     rcx, rsi
.fold_loop:
    mov     rdi, rax
    mov     esi, [r10]
    call    r9
    add     r10, r8
    loop    .fold_loop
.fold_exit:
    ret

global foldl
foldl:
    mov     r8, 4
    call    fold
    ret

global foldr
foldr:
    mov     r8, -4
    lea     rdi, [rdi + 4 * rsi - 4]
    call    fold
    ret

global append
append:
    lea     r12, [rsi + rcx]
    push    rcx
    push    rdx
    mov     rdx, r8
    lea     rcx, [rel write_elem]
    call    foldl
    pop     rdi
    pop     rsi
    mov     rdx, rax
    lea     rcx, [rel write_elem]
    call    foldl
    mov     rax, r12
    ret

global filter
filter:
    xor     r11, r11
    mov     r12, rdx
    mov     rdx, rcx
    lea     rcx, [rel .cond_write]
    call    foldl
    mov     rax, r11
    ret

.cond_write:
    push    rdi
    mov     rdi, rsi
    call    r12
    test    rax, rax
    je      .cond_exit
    inc     r11
    pop     rdi
    mov     [rdi], esi
    lea     rax, [rdi + 4]
    ret
.cond_exit:
    pop     rax
    ret

global map
map:
    push    rsi
    mov     r12, rdx
    mov     rdx, rcx
    lea     rcx, [rel .write_map_elem]
    call    foldl
    pop     rax
    ret

.write_map_elem:
    push    rdi
    mov     rdi, rsi
    call    r12
    pop     rdi
    mov     [rdi], eax
    lea     rax, [rdi + 4]
    ret

global reverse
reverse:
    push    rsi
    lea     rcx, [rel write_elem]
    call    foldr
    pop     rax
    ret
