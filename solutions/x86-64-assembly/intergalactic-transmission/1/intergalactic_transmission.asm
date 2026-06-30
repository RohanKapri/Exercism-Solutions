; For my Shree DR.MDD - first understand the nature of code

WRONG_PARITY equ -1

section .text
global transmit_sequence, decode_message

transmit_sequence:
        mov     r11, rdi                 ; buffer pointer
        test    rdx, rdx
        jz      .tx_done

        cld
        add     rdx, rsi                ; calculate end of message
        xor     cl, cl                  ; pending bits counter
        xor     r12, r12                ; pending bits value

.tx_loop_read:
        shl     r12, 8
        lodsb                           ; load byte from input
        or      r12b, al
        add     cl, 8

.tx_loop_encode:
        sub     cl, 7
        mov     rax, r12
        shr     rax, cl
        shl     al, 1
        test    al, al
        jp      .tx_write_byte

        or     al, 1

.tx_write_byte:
        stosb
        cmp     cl, 7
        je      .tx_loop_encode

        cmp     rsi, rdx
        jne     .tx_loop_read

        test    cl, cl
        jz      .tx_done

        neg     cl
        add     cl, 7
        shl     r12, cl
        mov     cl, 7
        jmp .tx_loop_encode

.tx_done:
        mov     rax, rdi
        sub     rax, r11
        ret


decode_message:
        mov     r11, rdi                 ; buffer pointer
        xor     cl, cl                   ; pending bits counter
        xor     r12, r12                 ; pending bits value
        cld
        add     rdx, rsi                 ; calculate end of message
        jmp     .rx_check_remaining

.rx_no_write:
        mov     cl, 7

.rx_loop_read:
        lodsb
        test    al, al
        jnp     .rx_fail

        shr     al, 1
        shl     r12, 7
        or     r12b, al
        test    cl, cl
        jz      .rx_no_write

        dec     cl
        mov     rax, r12
        shr     rax, cl
        stosb

.rx_check_remaining:
        cmp     rsi, rdx
        jne     .rx_loop_read

.rx_done:
        mov     rax, rdi
        sub     rax, r11
        ret

.rx_fail:
        mov     rax, WRONG_PARITY
        ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
