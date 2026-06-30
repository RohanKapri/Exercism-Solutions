section .text
global allergic_to
allergic_to:
    ; edi - enum item for allergy
    ; esi - score
    ; output in eax

    xor rax, rax
    bts esi, edi
    adc eax, eax
    ret

global list
list:
    ; edi - score
    ; rsi - pointer to item_list struct
    ; struct has one int size and
    ; one array of enum items
    ; struct is modified in place

    and edi, 255 ; filters out invalid values
    popcnt eax, edi ; counts bit sets (num of allergies)
    mov dword [rsi], eax ; sets size in the struct
    
    add rsi, 4 ; moves pointer to array
    xor rcx, rcx ; array index
    mov r8, -1 ; bit index
loop:
    cmp ecx, eax
    je end ; reached max num of allergies
    
    add r8, 1
    bts edi, r8d ; tests if bit is set
    jnc loop ; if not, continue
    
    mov dword [rsi + 4 * rcx], r8d ; adds bit index to array
    add rcx, 1 ; increments index in the array
    jmp loop
end:
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif