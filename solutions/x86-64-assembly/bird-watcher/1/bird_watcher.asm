default rel

section .data
    last_week db 0, 2, 5, 3, 7, 8, 4, 0

section .bss
    current_week resb 8
    current_count resq 1

section .text

global last_week_counts
global current_week_counts
global save_count
global today_count
global update_today_count
global update_week_counts

last_week_counts:
    mov rax, qword [last_week]
    ret

current_week_counts:
    mov rax, qword [current_week]
    mov rdx, qword [current_count]
    ret

save_count:
    mov rax, qword [current_week]
    mov rcx, qword [last_week]
    mov rdx, qword [current_count]
    xor esi, esi

    cmp edx, 7
    cmove rcx, rax
    cmove rax, rsi
    cmove rdx, rsi
    
    mov qword [last_week], rcx
    
    inc rdx
    mov qword [current_count], rdx
    
    mov qword [current_week], rax
    lea rcx, [current_week]
    mov byte [rcx + rdx - 1], dil
    ret

today_count:
    mov rcx, qword [current_count]
    lea rsi, [current_week]
    mov al, byte [rsi + rcx - 1]
    ret

update_today_count:
    mov rcx, qword [current_count]
    lea rsi, [current_week]
    add byte [rsi + rcx - 1], dil
    ret

update_week_counts:
    mov rsi, qword [current_week]
    mov qword [last_week], rsi
    mov qword [current_week], rdi
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
