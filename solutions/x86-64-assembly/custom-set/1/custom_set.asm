default rel

section .bss
    set_arr resq 256
    used_sets resb 8

section .text

global create_set
global set_empty
global set_contains
global set_subset
global set_disjoint
global set_equal
global set_add
global set_intersection
global set_difference
global set_union
global delete_set

%macro find_empty_set 1
    lzcnt r11, qword [used_sets]
    mov %1, 64
    sub %1, r11
    bts qword [used_sets], %1
    shl %1, 5
    lea r11, [set_arr]
    add %1, r11
%endmacro

%macro id_to_index 2
    lea %1, [set_arr]
    add %1, %2
%endmacro

create_set:
    ; RDI - num of elements in input array
    ; RSI - input array of int8_t
    ; result is a size_t (uint64_t) which uniquely identifies the set, in RAX

    find_empty_set r10
    
    test rdi, rdi
    jz .end_insert

    xor rax, rax
    mov rcx, rdi
.insert_loop:
    lodsb    

    movzx rdx, al
    and dl, 63 ; number % 64 is the index for the bit to be set
    shr al, 6 ; number / 64 is the index for the integer to be set

    bts qword [r10 + 8*rax], rdx ; bts sets the bit

    loop .insert_loop

.end_insert:
    lea r11, [set_arr]
    sub r10, r11
    mov rax, r10

    ret

set_empty:
    ; RDI - identifier for the set
    ; return is a boolean in RAX

    id_to_index r10, rdi

    vmovupd ymm0, [r10]
    vptest ymm0, ymm0
    setz al
    
    ret

set_contains:
    ; RDI - identifier for the set
    ; RSI - element (as a int8_t) to be searched
    ; return is a boolean in rax

    id_to_index r10, rdi
   
    movzx rcx, sil
    and cl, 63 ; number % 64 is the index for the bit to be set
    shr sil, 6 ; number / 64 is the index for the integer to be set

    lea r11, [r10 + 8*rsi]
    bt qword [r11], rcx ; checks if bit is set, stores result in CF
    setc al ; if CF is set, returns true, false otherwise

    ret

set_subset:
    ; RDI - identifier for first set
    ; RSI - identifier for second set
    ; return is a boolean in RAX

    id_to_index r10, rdi
    id_to_index r11, rsi

    vmovupd ymm1, [r10]
    vpand ymm1, ymm1, [r11]
    vptest ymm1, [r10]
    setc al
    
    ret

set_disjoint:
    ; RDI - identifier for first set
    ; RSI - identifier for second set
    ; return is a boolean in RAX

    id_to_index r10, rdi
    id_to_index r11, rsi

    vmovupd ymm1, [r10]
    vptest ymm1, [r11]
    setz al
 
    ret

set_equal:
    ; RDI - identifier for first set
    ; RSI - identifier for second set
    ; return is a boolean in RAX

    id_to_index r10, rdi
    id_to_index r11, rsi

    vmovupd ymm0, [r10]
    vpcmpeqq ymm0, ymm0, [r11]
    mov eax, 0xFFFFFFFF
    vmovd xmm1, eax
    vpbroadcastd ymm1, xmm1
    vptest ymm0, ymm1
    setc al
    
    ret

set_add:
    ; RDI - identifier for the set
    ; RSI - element (as a int8_t) to be added
    ; return is void

    id_to_index r10, rdi
    
    movzx rcx, sil
    and rsi, 63 ; number % 64 is the index for the bit to be set
    shr rcx, 6 ; number / 64 is the index for the integer to be set

    bts qword [r10 + 8*rcx], rsi ; bts sets bit in the index

    ret

set_intersection:
    ; RDI - id for first set
    ; RSI - id for second set
    ; return is id for the intersection set in RAX

    find_empty_set r9

    id_to_index r10, rdi
    id_to_index r11, rsi

    vmovupd ymm0, [r10]
    vpand ymm0, ymm0, [r11]
    vmovupd [r9], ymm0

    mov rax, r9
    lea r9, [set_arr]
    sub rax, r9

    ret

set_difference:
    ; RDI - id for first set
    ; RSI - id for second set
    ; return is id for the intersection set in RAX

    find_empty_set r9

    id_to_index r10, rdi
    id_to_index r11, rsi

    vmovupd ymm0, [r11]
    vpandn ymm0, ymm0, [r10]
    vmovupd [r9], ymm0

    mov rax, r9
    lea r9, [set_arr]
    sub rax, r9

    ret

set_union:
    ; RDI - id for first set
    ; RSI - id for second set
    ; return is id for the intersection set in RAX

    find_empty_set r9

    id_to_index r10, rdi
    id_to_index r11, rsi

    vmovupd ymm0, [r10]
    vpor ymm0, ymm0, [r11]
    vmovupd [r9], ymm0
    
    mov rax, r9
    lea r9, [set_arr]
    sub rax, r9

    ret

delete_set:
    ; RDI - set id
    ; return is void

    id_to_index r10, rdi
    shr rdi, 5
    btr qword [used_sets], rdi

    vpxor ymm0, ymm0, ymm0
    vmovupd [r10], ymm0

    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif