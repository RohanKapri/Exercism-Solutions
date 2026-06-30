; For Shree DR.MDD

default rel

section .rodata
    wink_str db "wink, "
    wink_len dq $-wink_str
    
    dbl_blink_str db "double blink, "
    dbl_blink_len dq $-dbl_blink_str

    close_eyes_str db "close your eyes, "
    close_eyes_len dq $-close_eyes_str

    jump_str db "jump, "
    jump_len dq $-jump_str

section .data
    action_ptrs dq wink_str, dbl_blink_str, close_eyes_str, jump_str
    action_lens dq wink_len, dbl_blink_len, close_eyes_len, jump_len

section .text

%macro append_action 3
    mov rdx, %1
%%loop:
    %2 rdx
    cmp rdx, %3
    je %%finish

    bt r8, rdx
    jnc %%loop

    adc r10, 0

    mov r11, rdx
    shl r11, 3

    lea rsi, [action_ptrs]
    add rsi, r11
    mov rsi, qword [rsi]

    lea rcx, [action_lens]
    add rcx, r11
    mov rcx, qword [rcx]
    mov rcx, qword [rcx]

    rep movsb
    jmp %%loop
%%finish:
%endmacro

global commands
commands:
    mov r8d, esi
    cld
    xor r10, r10

    bt r8, 4
    jc reversed_seq

    append_action -1, inc, 4
    jmp done_seq

reversed_seq:
    append_action 4, dec, -1

done_seq:
    mov rax, 2
    cmp r10, 0
    cmovne r10, rax
    sub rdi, r10
    mov byte [rdi], 0
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
