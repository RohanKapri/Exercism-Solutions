default rel

; State Enumeration
READY   equ 0
RUNNING equ 1
STOPPED equ 2

; Error Enumeration
SUCCESS         equ 0
ALREADY_RUNNING equ 1
NOT_RUNNING     equ 2
NOT_STOPPED     equ 3

section .bss
    align 8
    current_state   resb 1      ; Current stopwatch state (ready, running, stopped)
    lap_count       resq 1      ; Number of recorded laps (max 10)
    total_ticks     resq 1      ; Total seconds elapsed across all laps
    current_lap_ticks resq 1    ; Seconds elapsed in the current lap
    
    ; Memory pool for formatted strings (HH:MM:SS\0)
    ; 10 laps + 1 current + 1 total = 12 buffers
    ; Using 16-byte alignment per string for buffer safety
    string_pool     resb 12 * 16
    
    ; Array to store pointers to recorded lap strings
    history_ptrs    resq 10

section .text

global new
global start
global stop
global reset
global state
global lap
global current_lap
global previous_laps
global advance_time
global total

; void new(void)
new:
    lea rax, [rel current_state]
    mov byte [rax], READY
    lea rax, [rel lap_count]
    mov qword [rax], 0
    lea rax, [rel total_ticks]
    mov qword [rax], 0
    lea rax, [rel current_lap_ticks]
    mov qword [rax], 0
    ret

; state_t state(void)
state:
    lea rax, [rel current_state]
    movzx eax, byte [rax]
    ret

; error_t start(void)
start:
    lea rax, [rel current_state]
    movzx ecx, byte [rax]
    cmp ecx, RUNNING
    je .err_already_running
    
    mov byte [rax], RUNNING
    mov eax, SUCCESS
    ret
.err_already_running:
    mov eax, ALREADY_RUNNING
    ret

; error_t stop(void)
stop:
    lea rax, [rel current_state]
    movzx ecx, byte [rax]
    cmp ecx, RUNNING
    jne .err_not_running
    
    mov byte [rax], STOPPED
    mov eax, SUCCESS
    ret
.err_not_running:
    mov eax, NOT_RUNNING
    ret

; error_t lap(void)
lap:
    lea rax, [rel current_state]
    movzx ecx, byte [rax]
    cmp ecx, RUNNING
    jne .err_not_running
    
    lea rax, [rel lap_count]
    mov r8, [rax]
    cmp r8, 10
    jae .success_limit 
    
    ; Calculate pointer to the next slot in the pool
    lea rdi, [rel string_pool]
    mov rax, r8
    shl rax, 4
    add rdi, rax
    
    ; Format current lap ticks
    lea rax, [rel current_lap_ticks]
    mov rsi, [rax]
    push rdi ; Save pool address
    call internal_format_time
    pop rdi
    
    ; Store pointer in history
    lea rax, [rel history_ptrs]
    lea rcx, [rel lap_count]
    mov r8, [rcx]
    mov [rax + r8 * 8], rdi
    
    ; Update counts
    inc qword [rcx]
    lea rax, [rel current_lap_ticks]
    mov qword [rax], 0
    
.success_limit:
    mov eax, SUCCESS
    ret
.err_not_running:
    mov eax, NOT_RUNNING
    ret

; error_t reset(void)
reset:
    lea rax, [rel current_state]
    movzx ecx, byte [rax]
    cmp ecx, STOPPED
    jne .err_not_stopped
    
    call new
    mov eax, SUCCESS
    ret
.err_not_stopped:
    mov eax, NOT_STOPPED
    ret

; const char *current_lap(void)
current_lap:
    lea rdi, [rel string_pool + 10 * 16]
    lea rax, [rel current_lap_ticks]
    mov rsi, [rax]
    call internal_format_time
    lea rax, [rel string_pool + 10 * 16]
    ret

; const char *total(void)
total:
    lea rdi, [rel string_pool + 11 * 16]
    lea rax, [rel total_ticks]
    mov rsi, [rax]
    call internal_format_time
    lea rax, [rel string_pool + 11 * 16]
    ret

; size_t previous_laps(const char *buffer[])
previous_laps:
    lea rax, [rel lap_count]
    mov rcx, [rax]
    test rcx, rcx
    jz .done
    
    lea r9, [rel history_ptrs]
    mov r8, 0
.loop:
    mov rax, [r9 + r8 * 8]
    mov [rdi + r8 * 8], rax
    inc r8
    cmp r8, rcx
    jl .loop
.done:
    mov rax, rcx
    ret

; void advance_time(const char *by)
advance_time:
    lea rax, [rel current_state]
    movzx eax, byte [rax]
    cmp eax, RUNNING
    jne .skip
    
    push rbx
    push r12
    mov r12, rdi ; Input string

    ; Parse Hours
    movzx eax, byte [r12]
    sub eax, '0'
    imul eax, 10
    movzx ecx, byte [r12 + 1]
    sub ecx, '0'
    add eax, ecx
    imul rax, 3600
    mov rbx, rax

    ; Parse Minutes
    movzx eax, byte [r12 + 3]
    sub eax, '0'
    imul eax, 10
    movzx ecx, byte [r12 + 4]
    sub ecx, '0'
    add eax, ecx
    imul rax, 60
    add rbx, rax

    ; Parse Seconds
    movzx eax, byte [r12 + 6]
    sub eax, '0'
    imul eax, 10
    movzx ecx, byte [r12 + 7]
    sub ecx, '0'
    add eax, ecx
    add rbx, rax
    
    ; Update ticks
    lea rax, [rel current_lap_ticks]
    add [rax], rbx
    lea rax, [rel total_ticks]
    add [rax], rbx
    
    pop r12
    pop rbx
.skip:
    ret

; --- Internal Helpers ---

; rdi = buffer, rsi = seconds
internal_format_time:
    push rbx
    push r12
    push r13
    push r14
    mov r12, rdi ; Base buffer

    mov rax, rsi
    xor rdx, rdx
    mov rcx, 3600
    div rcx      ; rax = HH, rdx = rem
    mov r13, rdx ; r13 = remaining secs
    mov rbx, rax ; rbx = HH
    
    mov rax, r13
    xor rdx, rdx
    mov rcx, 60
    div rcx      ; rax = MM, rdx = SS
    mov r13, rax ; r13 = MM
    mov r14, rdx ; r14 = SS

    ; Write HH
    mov rdi, r12
    mov rax, rbx
    call internal_write_digits
    mov byte [r12 + 2], ':'

    ; Write MM
    lea rdi, [r12 + 3]
    mov rax, r13
    call internal_write_digits
    mov byte [r12 + 5], ':'

    ; Write SS
    lea rdi, [r12 + 6]
    mov rax, r14
    call internal_write_digits
    mov byte [r12 + 8], 0

    pop r14
    pop r13
    pop r12
    pop rbx
    ret

; rdi = buffer, rax = val
internal_write_digits:
    xor rdx, rdx
    mov rcx, 10
    div rcx
    add al, '0'
    add dl, '0'
    mov [rdi], al
    mov [rdi + 1], dl
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif