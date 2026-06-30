section .text
global largest
global smallest

cmp_greater:
    cmp r11, rcx
    sete al
    seta dl
    ret

cmp_smaller:
    cmp r11, rcx
    sete al
    setb dl
    ret

largest:    
    push r14                     ; save callee-saved register, for storing callback
    lea r14, [rel cmp_greater]   ; callback
    xor r11d, r11d               ; we want the largest, so comparison is with MIN_UINT64

    ; fallthroughs
    
find_and_add:
    cmp rsi, rdx
    ja .invalid
    
    push rbx                      
    push r12
    push r13
    
    mov r12, rdx                 ; upper bound, because rdx will be modified
    mov rbx, rdi                 ; start of struct, in case store is reset 
    add rdi, 8                   ; start of buffer
    mov r10, 10                  ; for getting digits
.outer:
    cmp rsi, r12                 
    ja .end_outer                ; min larger than max, end loop
    
    mov r8, rsi                  ; we want results in ascending order
.inner:
    cmp r8, r12
    ja .end_inner                ; current value larger than max, end loop

    mov r9, r8
    imul r9, rsi                 ; current value * current min
    mov rcx, r9                  ; store for comparison after getting reverse
    xor r13d, r13d               ; accumulator for getting reverse
.extract_digits: 
    test r9, r9
    jz .end_extract              ; continue extracting digits until number is 0
       
    mov rax, (-1 / 10) + 1       ; this follow the method here: https://lemire.me/blog/2019/02/08/faster-remainders-when-the-divisor-is-a-constant-beating-compilers-and-libdivide/
    mul r9
    mov r9, rdx                  ; store quotient
    mul r10                      ; rdx now has remainder, i.e., digit

    imul rax, r13, 10
    lea r13, [rax + rdx]         ; accumulator now holds reverse with digit
    
    jmp .extract_digits    
.end_extract:
    cmp r13, rcx
    jnz .prepare_inner           ; reverse != number -> number is not palindromic

    call r14                     ; apply callback
    
    test al, al 
    jnz .add                     ; current number is equal to current result (either largest or smallest). Add pair

    test dl, dl
    jnz .prepare_inner           

    ; current number should replace current result (it is either largest or smallest)
    
    mov qword [rbx], 0           ; reset counter
    lea rdi, [rbx + 8]           ; reset pointer to buffer
    mov r11, rcx                 ; replace current result
.add:
    inc qword [rbx]              ; increase counter
    mov qword [rdi], rsi         ; add smallest element first
    mov qword [rdi + 8], r8      ; add largest element second
    add rdi, 16                  ; move pointer to next pair
    
.prepare_inner:
    inc r8                       ; increase current number, for next iteration in inner loop
    jmp .inner
    
.end_inner:
    inc rsi                      ; increase min, for next iteration in outer loop
    jmp .outer
    
.end_outer:

    ; epilogue
    
    pop r13
    pop r12
    pop rbx
    pop r14

    ; this is needed given the different initial values for r11 (either MIN_UINT64 or MAX_UINT64)
    
    xor eax, eax                 ; default is empty value
    cmp r11, 0                   
    cmovg rax, r11               ; if result is larger, move it for returning
    ret
    
.invalid:
    mov rax, -1                  ; invalid result must return -1
    
    ; restore callback pointer
    
    pop r14
    ret

smallest:
    push r14                   ; save callee-saved register for storing callback
    lea r14, [rel cmp_smaller] ; callback
    mov r11, -1                ; we want the smallest, so comparison is with MAX_UINT64
    
    jmp find_and_add           ; tail call

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif