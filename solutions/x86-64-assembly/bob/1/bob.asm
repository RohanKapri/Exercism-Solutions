; For Shree DR.MDD

default rel

section .data
Msg1  db "Whatever.",0
Msg2  db "Sure.",0
Msg3  db "Whoa, chill out!",0
Msg4  db "Calm down, I know what I'm doing!",0
Msg5  db "Fine. Be that way!",0
Answers dq Msg1, Msg2, Msg3, Msg4, Msg5

section .text
global response
response:
    xor     rax, rax              
    xor     rdx, rdx               
    mov     rcx, 4                  

.scan_loop:  
    cmp     [rdi], byte 0
    je      .done

    cmp     [rdi], byte ' '
    jle     .advance

    cmp     [rdi], byte '?'
    sete    cl                      

    cmp     [rdi], byte 'z'
    jg      .advance
    cmp     [rdi], byte 'a'
    setge   al                
    or      dl, al                 

    cmp     [rdi], byte 'Z'
    jg      .advance
    cmp     [rdi], byte 'A'
    setge   al                
    or      dh, al                 

.advance:
    inc     rdi
    jmp     .scan_loop

.done:
    cmp     dh, dl
    setg    al                   
    lea     rcx, [rcx + 2 * rax]
    lea     rdi, Answers
    mov     rax, [rdi + 8 * rcx]
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
