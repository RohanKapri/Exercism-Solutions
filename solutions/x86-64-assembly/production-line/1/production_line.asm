section .rodata
align 16
factor: dq 0.5, 0.5

section .text

global sum_yields
sum_yields:
    movaps xmm0, oword [rdi]
    addps  xmm0, oword [rsi]
    movaps oword [rdx], xmm0
    ret

; with AVX/AVX2
; sum_yields:
;    vmovaps xmm0, [rdi]
;    vaddps  xmm0, xmm0, [rsi]
;    vmovaps [rdx], xmm0
;    ret

global scaled_deviation
scaled_deviation:
    movapd xmm0, oword [rdi]
    movupd xmm1, oword [rsi]
    subpd  xmm0, xmm1
    movupd xmm1, oword [rdx]
    mulpd  xmm0, xmm1
    movupd oword [rcx], xmm0
    ret

; with AVX/AVX2
; scaled_deviation:
;    vmovapd xmm0, [rdi]
;    vsubpd  xmm0, xmm0, [rsi]
;    vmulpd  xmm0, xmm0, [rdx]
;    vmovupd [rcx], xmm0
;    ret

global calibrate_batch
calibrate_batch:
    movapd   xmm0, oword [rsi]        ; reference
    movapd   xmm1, oword [rdx]        ; offset
    movapd   xmm2, oword [rel factor] ; factor

    cvtps2pd xmm3, qword [rdi]        ; first row
    cvtps2pd xmm4, qword [rdi + 8]    ; second row

    subpd    xmm3, xmm1
    subpd    xmm4, xmm1

    movapd   xmm1, xmm0
    divpd    xmm0, xmm3
    divpd    xmm1, xmm4

    mulpd    xmm0, xmm2
    mulpd    xmm1, xmm2

    movapd   oword [rcx]     , xmm0
    movapd   oword [rcx + 16], xmm1
    ret

; with AVX/AVX2
; calibrate_batch:
;    vmovapd   xmm0, [rsi]        ; reference
;    vmovapd   xmm1, [rdx]        ; offset
;    vmovapd   xmm2, [rel factor] ; factor

;    vcvtps2pd xmm3, [rdi]        ; first row
;    vcvtps2pd xmm4, [rdi + 8]    ; second row

;    vsubpd    xmm3, xmm3, xmm1
;    vsubpd    xmm4, xmm4, xmm1

;    vdivpd    xmm3, xmm0, xmm3
;    vdivpd    xmm4, xmm0, xmm4

;    vmulpd    xmm3, xmm3, xmm2
;    vmulpd    xmm4, xmm3, xmm2

;    vmovapd   [rcx]     , xmm3
;    vmovapd   [rcx + 16], xmm4
;    ret

global normalize_scores
normalize_scores:
    movapd xmm1, oword [rdx]
.loop:
    movapd xmm0, oword [rdi + 8*rcx - 16]
    mulpd  xmm0, oword [rsi + 8*rcx - 16]
    divpd  xmm0, xmm1
    movapd oword [rdi + 8*rcx - 16], xmm0
    sub rcx, 2
    jnz .loop
    ret

; with AVX/AVX2
; normalize_scores:
;    vmovapd xmm1, [rdx]
;.loop:
;    vmovapd xmm0, [rdi + 8*rcx - 16]
;    vmulpd  xmm0, xmm0, [rsi + 8*rcx - 16]
;    vdivpd  xmm0, xmm0, xmm1
;    vmovapd [rdi + 8*rcx - 16], xmm0
;    sub rcx, 2
;    jnz .loop
;    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif