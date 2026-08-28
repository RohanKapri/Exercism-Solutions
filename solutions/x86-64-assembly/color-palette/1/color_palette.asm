default rel

section .rodata
    global RED, GREEN, BLUE
    
    RED dd 0xFF000000
    GREEN dd 0x00FF0000
    BLUE dd 0x0000FF00

section .data
    global base_color
    
    base_color dd 0xFFFFFF00

section .text

global get_color_value, add_base_color, make_color_combination

extern combining_function

get_color_value:
    mov eax, dword [rdi]
    ret

add_base_color:
    mov eax, dword [rdi]
    mov dword [base_color], eax
    ret

make_color_combination:
    push rdi
        
    mov edi, dword [base_color]
    mov esi, dword [rsi]
    call combining_function
    
    pop rdi
    mov dword [rdi], eax
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif