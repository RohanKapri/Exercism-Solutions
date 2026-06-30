PRIVATE_KEY equ 0b1011_0011_0011_1100

section .text

global extract_higher_bits
extract_higher_bits:
    shr di, 8
    mov al, dil
    ret

global extract_lower_bits
extract_lower_bits:
    mov al, dil
    ret

global extract_redundant_bits
extract_redundant_bits:
    mov al, dil
    shr di, 8
    and al, dil
    ret

global set_message_bits
set_message_bits:
    mov al, dil
    shr di, 8
    or al, dil
    ret

global rotate_private_key
rotate_private_key:
    call extract_redundant_bits
    movzx cx, al
    popcnt cx, cx
    mov ax, PRIVATE_KEY
    rol ax, cl
    ret

global format_private_key
format_private_key:
    call rotate_private_key
    mov di, ax
    shr di, 8
    xor al, dil
    not al
    ret

global decrypt_message
decrypt_message:
    mov r8w, di
    call format_private_key
    shl ax, 8
    mov di, r8w
    call set_message_bits
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif