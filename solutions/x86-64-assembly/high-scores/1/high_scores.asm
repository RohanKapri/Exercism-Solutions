section .text

global latest
global personal_best
global personal_top_three

latest:
    ; accesses the last element in the array in rsi
    ; using the size in rdi
    ; and moves that element to eax, for returning it

    mov eax, dword [rsi + 4*rdi - 4]
    ret

personal_best:
    ; iterates over the elements in the array in rsi
    ; using the size in rdi
    ; continously compares the element with an accumulator starting as 0
    ; and, if the element is greater, moves it to the accumulator
    ; for returning it

    xor eax, eax
    mov rcx, rdi
.accumulate:
    mov edx, dword [rsi + 4*rcx - 4]
    cmp edx, eax
    cmovg eax, edx
    dec rcx
    jnz .accumulate
    ret

personal_top_three:
    ; gets the size of the output array,
    ; which is the lesser of 3 or the size of the input array
    ; initializes the first 3 elements of the output as 0
    ; iterates over elements in the input
    ; compares each element with the first elements of the output, up to its size
    ; if the element is greater than the corresponding element in output, exchanges both

    mov eax, 3
    cmp rdx, 3
    cmovl eax, edx

    mov dword [rdi], 0
    mov dword [rdi + 4], 0
    mov dword [rdi + 8], 0

    mov ecx, edx
.get_values:
    mov r8d, dword [rsi + 4*rcx - 4]
    mov r9d, -1
.compare_values:
    inc r9d
    cmp r9d, eax
    je .end_compare

    mov r10d, dword [rdi + 4*r9]
    mov r11d, r10d
    cmp r8d, r10d
    cmovg r10d, r8d
    cmovg r8d, r11d
    mov dword [rdi + 4*r9], r10d

    jmp .compare_values

.end_compare:
    dec ecx
    jnz .get_values

    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif