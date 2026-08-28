; For Shree DR.MDD

section .text
global is_pangram
is_pangram:
    xor r13d, r13d              ; total mask
    mov r14, -1                  ; index
    mov rsi, rdi                 ; save input pointer

.loop_scan:
    add r14, 1
    movzx edi, byte [rsi + r14] ; load character
    test edi, edi
    jz .finish_loop

    call char_to_mask             ; convert char to mask
    test eax, eax
    jz .loop_scan

    or r13d, eax
    jmp .loop_scan

.finish_loop:
    xor eax, eax
    cmp r13d, 0x3ffffff
    sete al
    ret

char_to_mask:
    xor eax, eax
    or rdi, 32
    sub rdi, 'a'
    cmp rdi, 26
    jae .mask_end
    bts eax, edi
.mask_end:
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
