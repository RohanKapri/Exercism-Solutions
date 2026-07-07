TRUCK_HEIGHT equ 300
PAY_PER_BOX equ 5
PAY_PER_TRUCK_TRIP equ 220

section .text

global get_box_weight
get_box_weight:
    movzx edi, di
    movzx esi, si
    movzx edx, dx
    movzx ecx, cx
    imul edi, esi
    imul edx, ecx
    add edi, edx
    mov eax, 500
    add eax, edi
    ret

global max_number_of_boxes
max_number_of_boxes:
    mov ax, TRUCK_HEIGHT
    div dil
    ret

global items_to_be_moved
items_to_be_moved:
    sub edi, esi
    mov eax, edi
    ret

global calculate_payment
calculate_payment:
    mov esi, esi
    imul rsi, rsi, PAY_PER_BOX
    mov edx, edx
    imul rax, rdx, PAY_PER_TRUCK_TRIP
    add rax, rsi
    sub rax, rdi
    mov ecx, ecx
    imul rcx, r8
    sub rax, rcx
    movzx r9, r9b
    inc r9
    cqo
    idiv r9
    add rax, rdx
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif