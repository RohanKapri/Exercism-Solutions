; Dedicated to my Shree DR.MDD

section .text
global encode, decode

decode:
    cld
    jmp .process_decode

.decode_lower:
    neg al
    add al, 'a' + 'z'

.decode_store:
    stosb

.process_decode:
    lodsb
    cmp al, '9'
    ja .decode_lower
    cmp al, ' '
    je .process_decode
    test al, al
    jnz .decode_store

done:
    stosb
    ret

encode:
    cld
    mov cl, 6
    jmp .process_encode

.encode_letter:
    or al, 32
    sub al, 'a'
    cmp al, 26
    jae .process_encode
    neg al
    add al, 'z'

.encode_store:
    dec cl
    jnz .write_char

    mov cl, al
    mov al, ' '
    stosb
    mov al, cl
    mov cl, 5

.write_char:
    stosb

.process_encode:
    lodsb
    cmp al, '9'
    ja .encode_letter
    test al, al
    jz done
    cmp al, '0'
    jl .process_encode
    jmp .encode_store

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
