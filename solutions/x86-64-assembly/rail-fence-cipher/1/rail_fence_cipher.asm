section .text
global encode
global decode

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; traverse src1, dest1, src2, dest2
;
; In a rail-fence cipher with N rails, the matching positions for each
; rail repeat with period p = 2*N - 2.
;
; The first rail (index 0) and the last rail (index N-1) have one
; matching position per period, starting at the rail's own index.
; Every other rail has two matching positions per period, starting at:
;   1. the rail's index
;   2. p - rail
;
; We iterate over rails, calculating the matching positions.
; We copy the characters at those positions into the stack.
; Finally, we copy back the modified string into the output buffer.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%macro traverse 4
    cmp rsi, 1
    je %%end                  ; 1 rail, returns right away

    sub rsp, 64               ; prologue

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; Since the buffer is 64 bytes wide, all of the following are valid:
    ;
    ; 1. ordinary loops
    ; 2. SSE SIMD instructions (16 bytes wide)
    ; 3. AVX2 SIMD instructions (32 bytes wide)
    ; 4. AVX-512 SIMD instructions (64 bytes wide)
    ; 
    ; This solution uses AVX2, which is often a pragmatic choice,
    ; given the somewhat lackluster support of AVX-512 in modern CPUs
    ;
    ; A solution using AVX-512 could follow the same general structure as this one, with some adaptations.
    ; For example, the use of mask registers
    ;
    ; The example solution on GitHub uses SSE:
    ; https://github.com/exercism/x86-64-assembly/blob/main/exercises/practice/rail-fence-cipher/.meta/example.asm
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    vpxor    ymm0, ymm0, ymm0
    vpcmpeqb ymm1, ymm0, [rdi]
    vpcmpeqb ymm2, ymm0, [rdi + 32]
    vpmovmskb ecx, ymm1
    vpmovmskb edx, ymm2
    shl rdx, 32
    or  rcx, rdx
    tzcnt rcx, rcx            ; string length

    lea r10, [rsi + rsi - 2]  ; period
    xor r8d, r8d              ; rail
    xor edx, edx
%%loop:
    cmp r8, rsi
    jae %%end_loop

    mov r9, r8
    mov r11, r10
    sub r11, r8

    test r9, r9
    jz %%single                ; fst rail has 1 position per cycle
    
    cmp r9, r11
    jz %%single                ; lst rail has 1 position per cycle

    ; all other rails have 2 positions per cycle
%%pair:
    cmp r9, rcx
    jae %%next

    movzx eax, byte [rdi + %1]
    mov byte [rsp + %2], al

    inc rdx

    cmp r11, rcx
    jae %%next

    movzx eax, byte [rdi + %3]
    mov byte [rsp + %4], al

    inc rdx

    add r9, r10                ; increments first position
    add r11, r10               ; increments second position
    jmp %%pair

%%single:
    cmp r9, rcx
    jae %%next

    movzx eax, byte [rdi + %1]
    mov byte [rsp + %2], al

    inc rdx

    add r9, r10                ; increments position
    jmp %%single

%%next:
    inc r8                     ; next rail
    jmp %%loop

%%end_loop:
    ; encoded/decoded string is on stack
    ; copies back to destination buffer
    vmovdqu ymm1, [rsp]
    vmovdqu ymm2, [rsp + 32]
    vmovdqu [rdi], ymm1
    vmovdqu [rdi + 32], ymm2
    mov byte [rdi + rcx], 0   ; NULL
    
    vzeroupper
    add rsp, 64               ; epilogue
%%end:
%endmacro

; extern void encode(char message[], size_t rails);
; message is modified in-place
encode:
    traverse r9, rdx, r11, rdx
    ret

; extern void decode(char message[], size_t rails);
; message is modified in-place
decode:
    traverse rdx, r9, rdx, r11
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif