; For my Shree DR.MDD - first understand the nature of code

default rel

section .data

f_1: db "fly",0
f_2: db "spider",0
f_3: db "bird",0
f_4: db "cat",0
f_5: db "dog",0
f_6: db "goat",0
f_7: db "cow",0
f_8: db "horse",0
fa: dq f_1,f_2,f_3,f_4,f_5,f_6,f_7,f_8,0

snt1: db "I know an old lady who swallowed a ",0
snt2: db ".",10,0
snt3: db "It wriggled and jiggled and tickled inside her.",10,0
snt4: db "How absurd to swallow a bird!",10,0
snt5: db "Imagine that, to swallow a cat!",10,0
snt6: db "What a hog, to swallow a dog!",10,0
snt7: db "Just opened her throat and swallowed a goat!",10,0
snt8: db "I don't know how she swallowed a cow!",10,0
snt9: db "She's dead, of course!",10,0
sntset1: dq snt3,snt4,snt5,snt6,snt7,snt8,snt9,0

snt10: db "She swallowed the cow to catch the goat.",10,0
snt11: db "She swallowed the goat to catch the dog.",10,0
snt12: db "She swallowed the dog to catch the cat.",10,0
snt13: db "She swallowed the cat to catch the bird.",10,0
snt14: db "She swallowed the spider to catch the fly.",10,0
snt15: db "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.",10,0
snt16: db "I don't know why she swallowed the fly. Perhaps she'll die.",10,0
sntset2: dq snt10,snt11,snt12,snt13,snt15,snt14,snt16,0

section .text
global copystr
copystr:
    ; rsi - source
    ; rdi - dest
.loop_copy:
    cmp byte [rsi],0
    jz .done_copy
    mov al,[rsi]
    mov [rdi],al
    inc rsi
    inc rdi
    jmp .loop_copy
.done_copy:
    mov byte [rdi],0
    ret

global recite
recite:
    mov rbx,rsi
.start_loop:
    cmp rbx,rdx
    jg .exit_loop

    lea rsi,[snt1]
    call copystr

    lea rsi,[fa]
    mov rsi,[rsi + rbx*8 - 8]
    call copystr

    lea rsi,[snt2]
    call copystr

    cmp rbx,1
    jle .single_done
    lea rsi,[sntset1]
    mov rsi,[rsi + rbx*8 - 16]
    call copystr
.single_done:

    mov rcx,rbx
    cmp rcx,8
    jge .loop_continue
.specific_loop:
    dec rcx
    jl .loop_continue
    lea rsi,[sntset2]
    lea r8,[rcx*8 - 48]
    sub rsi,r8
    mov rsi,[rsi]
    call copystr
    jmp .specific_loop
.loop_continue:
    cmp rbx,rdx
    je .newline_add
    mov byte [rdi],10
    inc rdi
.newline_add:
    inc rbx
    jmp .start_loop
.exit_loop:
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
