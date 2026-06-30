section .rodata
align 16

SIGN_MASK: dd 0, 0x80000000, 0, 0

C1:   dd -0.16666666666666667, -0.5    ; - 1 / 3!, - 1 / 2!
      dd 0.16666666666666667, 0.5      ; 1 / 3!, 1 / 2!

C2:   dd 0.008333333333333333          ; 1 / 5!
      dd 0.04166666666666667, 0, 0     ; 1 / 4!

C3:   dd -0.0001984126984126984        ; - 1 / 7!
      dd -0.001388888888888889         ; - 1 / 6!
      dd 0.0001984126984126984         ;  1 / 7!
      dd 0.001388888888888889          ;  1 / 6!

C4:   dd 2.7557319223985893e-06        ; 1 / 9!
      dd 2.4801587301587302e-05, 0, 0  ; 1 / 8!

C5:   dd -2.5052108385441720e-08       ; -1 / 11!
      dd -2.7557319223985890e-07, 0, 0 ; -1 / 10!

TWO_DIV_PI: times 4 dd 0.63661977236   ; 2 / PI
PI_DIV_TWO: times 4 dd 1.57079632679   ; PI / 2
ONE: times 4 dd 1.0

ONE_DIV_LOG2: dd 1.4426950408889634
LN2: dd 0.693147180559

FLOOR equ 1

section .text

global complex_real
global complex_imaginary
global complex_mul
global complex_add
global complex_sub
global complex_div
global complex_abs
global complex_conjugate
global complex_exp
global complex_real_add
global real_complex_add
global complex_real_sub
global real_complex_sub
global complex_real_mul
global real_complex_mul
global complex_real_div
global real_complex_div

%macro mult_add 4
   vmul %+ %1 %+ s %2, %2, %3
   vadd %+ %1 %+ s %2, %2, %4
%endmacro

%macro exp_taylor 0
    ; This macro calculates e^x
    ;
    ; For a large x, taylor expansion takes much longer to converge
    ; so we first reduce x to a small r and to a power of two k
    ;
    ; We know that e^x = 2^(x * log2(e)) = 2^(x / ln2)
    ;
    ; let z = x / ln2 and z = k + f, where k = floor(z) and f < 1
    ; then 2^z = 2^(k + f) = 2^k + 2^f
    ;
    ; let r = x - k*ln2 = z*ln2 - k*ln2 = ln2*(z - k) = ln2*f
    ; then 2^f = e^(ln2*f) = e^r
    ;
    ; so e^x = 2^k * e^r
    ;
    ; r is small, so we can calculate e^r with taylor expansion
    ; and 2^k can be applied directly to e^r 
    ; with shifts on the raw IEEE exponent field

    vmulss xmm1, xmm4, [rel ONE_DIV_LOG2] 
    ; xmm1 = x * log2e = x / ln2 = z
    vroundss xmm1, xmm1, FLOOR   ; xmm1 = floor(z) = k
    vcvtss2si eax, xmm1    ; we save k to shift the result later

    ; now we need to calculate r = x - k*ln2
    vmulss xmm2, xmm1, [rel LN2]     ; xmm2 = k*kn2
    vsubss xmm4, xmm4, xmm2                 ; xmm4 = x - k*ln2 = r

    ; now we calculate the taylor expansion of r with 7 factors:
    ; e^r = 1 + (r^2)/2! + ... + (r^7)/7!
    ;
    ; the inverse of the factorials are already precomputed
    ; we start from 1/7! and continuously:
    ; 1. multiply x and
    ; 2. add the next factorial inverse

    vmovss xmm2, [rel ONE] 
    ; cache 1.0 in xmm2 to be used later. This saves one memory load

    vmulss xmm1, xmm4, [rel C3 + 8]
    vaddss xmm1, xmm1, [rel C3 + 12]
    mult_add s, xmm1, xmm4, [rel C2]
    mult_add s, xmm1, xmm4, [rel C2 + 4]
    mult_add s, xmm1, xmm4, [rel C1 + 8]
    mult_add s, xmm1, xmm4, [rel C1 + 12]
    mult_add s, xmm1, xmm4, xmm2
    mult_add s, xmm1, xmm4, xmm2

    ; now xmm1 = e^r

    add eax, 127    ; offset
    shl eax, 23
    vmovd xmm2, eax ; now xmm2 is 2^k in IEEE format

    vmulss xmm1, xmm1, xmm2 ; xmm1 = e^r * 2^k = e^x
    vpermilps xmm4, xmm1, 0b00_00_00_00 
    ; we pack e^x in the first two lanes of xmm4
%endmacro

%macro sin_cos_taylor 0
   vinsertps xmm0, xmm0, xmm0, 0b01_00_1100

   ; xmm0 now holds the angle on the two first lanes
   ; we calculate sin and cos on both lanes in parallel using SIMD

   vmovaps xmm2, [rel ONE]   ; 1.0f
   vmulps xmm1, xmm0, [rel TWO_DIV_PI]  ; (2 / PI) * angle
   vroundps xmm1, xmm1, FLOOR     
   ; xmm1 = floor ((2 / PI) * angle) -> the whole num of quadrants
   vcvtss2si eax, xmm1  ; eax mod 4 indicates the quadrant

   ; This follows from:
   ;
   ; let the angle be denoted as 2 * PI * r + k, where k < 2 * PI
   ;
   ; (2 * PI * r + k) * (2 / PI) = 4 * r + 2 * k / PI
   ; (4 * r) % 4 == 0 -> (4 * r + 2 * k / PI) % 4 = (2 * k / PI) % 4
   ;
   ; (2 * k / PI) % 4 == 0 -> k < PI / 2     (1º quadrant)
   ; (2 * k / PI) % 4 == 1 -> k < PI         (2º quadrant)
   ; (2 * k / PI) % 4 == 2 -> k < 3 * PI / 2 (3º quadrant)
   ; (2 * k / PI) % 4 == 3 -> k < 2 * PI     (4º quadrant)
   ;
   ; since k < 2 * PI, we've exhausted all options

   vmulps xmm1, xmm1, [rel PI_DIV_TWO]  
   ; xmm1 = floor ((2 / PI) * angle) * (PI / 2)
   ; xmm1 holds the angle corresponding to the whole n of quadrants

   vsubps xmm0, xmm0, xmm1 
   ; xmm0 = angle - (floor ((2 / PI) * angle) * (PI / 2))
   ; xmm0 holds the residual angle x, reduced to the 1° quadrant

   ; we go backwards from the last term in the taylor expansion
   ; so that multiplication accumulates correctly
   ; at the end the factor divided by n! will correspond to x^n
   
   vmulps xmm1, xmm0, xmm0
   ; xmm1 = x^2
   vmulps  xmm3, xmm1, [rel C5]
   ; sin = -(x^2 / 11!)
   ; cos = -(x^2 / 10!)
   vaddps  xmm3, xmm3, [rel C4]
   ; sin = -(x^2 / 11!) + 1/9!
   ; cos = -(x^2 / 10!) + 1/8!
   ; and so on...
   mult_add p, xmm3, xmm1, [rel C3]
   mult_add p, xmm3, xmm1, [rel C2]
   mult_add p, xmm3, xmm1, [rel C1]
   mult_add p, xmm3, xmm1, xmm2
   vmulss xmm3, xmm3, xmm0 
   
   ; cos is complete, sin requires one extra multiplication by x

   ; sin and cos are for the reduced angle at the 1° quadrant
   ; So this is our base case
   ;
   ; For the other quadrants, we rely on the following:
   ; 1. on the 2° quadrant, cos is negative and sin is positive
   ; 2. on the 3° quadrant, cos is negative and sin is negative
   ; 3. on the 4° quadrant, cos is positive and sin is negative
   ; 4. sin and cos change places on the 2° and 4° quadrants.
   ;
   ; This last statement follows geometrically, given that:
   ; 1. sin is the y of the vector on the unit circle
   ; 2. cos is the x of the vector on the unit circle

   ; we now check the quadrant
   and eax, 3
   jz %%first

   cmp eax, 2
   jz %%third
   jb %%second

   vxorps xmm0, xmm3, [rel SIGN_MASK]
   jmp %%end
%%second:
   vxorps xmm0, xmm3, [rel SIGN_MASK + 4]
   jmp %%end
%%third:
   vxorps xmm3, xmm3, [rel SIGN_MASK]
   vxorps xmm3, xmm3, [rel SIGN_MASK + 4]
%%first:
   vpermilps xmm0, xmm3, 0b00_00_00_01
%%end:
%endmacro

complex_real:
    ; result is already in xmm0
    ret

complex_imaginary:
    vinsertps xmm0, xmm0, xmm0, 0b01_00_1110
    ret

complex_abs:
    vmulps xmm1, xmm0, xmm0
    vpermilps xmm2, xmm1, 0b00_00_00_01
    vaddps xmm0, xmm1, xmm2
    vsqrtss xmm0, xmm0, xmm0
    ret

complex_conjugate:
    vxorps xmm0, xmm0, [rel SIGN_MASK]
    ret

complex_exp:
    vmovaps xmm4, xmm0
    exp_taylor
    sin_cos_taylor
    vmulps xmm0, xmm0, xmm4
    ret

real_complex_add:
    vinsertps xmm0, xmm0, xmm0, 0b00_00_1110
    jmp complex_add
complex_real_add:
    vinsertps xmm1, xmm1, xmm1, 0b00_00_1110
complex_add:
    vaddps xmm0, xmm0, xmm1
    ret

real_complex_sub:
    vinsertps xmm0, xmm0, xmm0, 0b00_00_1110
    jmp complex_sub
complex_real_sub:
    vinsertps xmm1, xmm1, xmm1, 0b00_00_1110
complex_sub:
    vsubps xmm0, xmm0, xmm1
    ret

real_complex_mul:
    vinsertps xmm0, xmm0, xmm0, 0b00_00_1110
    jmp complex_mul
complex_real_mul:
    vinsertps xmm1, xmm1, xmm1, 0b00_00_1110
complex_mul:
    vpermilps xmm0, xmm0, 0b00_01_01_00 ; [a, b, b, a]
    vpermilps xmm1, xmm1, 0b01_01_00_00 ; [c, c, d, d]
    vmulps xmm0, xmm0, xmm1             ; [a*c, b*c, b*d, a*d]
    vpermilps xmm1, xmm0, 0b00_00_11_10 ; [b*d, a*d, _, _]
    vaddsubps xmm0, xmm0, xmm1
    ret

real_complex_div:
    vinsertps xmm0, xmm0, xmm0, 0b00_00_1110
    jmp complex_div
complex_real_div:
    vinsertps xmm1, xmm1, xmm1, 0b00_00_1110
complex_div:
    vmulps xmm2, xmm1, xmm1
    vpermilps xmm3, xmm2, 0b00_00_00_01
    vaddps xmm2, xmm2, xmm3
    vpermilps xmm0, xmm0, 0b01_00_00_01    ; [b, a, a, b]
    vpermilps xmm1, xmm1, 0b01_01_00_00    ; [c, c, d, d]
    vmulps xmm0, xmm0, xmm1                ; [b*c, a*c, a*d, b*d]
    vpermilps xmm1, xmm0, 0b00_00_11_10    ; [a*d, b*d, _, _]
    vaddsubps xmm0, xmm0, xmm1             ; [b*c - a*d, a*c + b*d]
    vdivps xmm0, xmm0, xmm2           
    ; [(b*c - a*d)/(c^2 + d^2), (a*c + b*d)/(c^2 + d^2)]
    vpermilps xmm0, xmm0, 0b00_00_00_01   
    ; swap -> [(a*c + b*d)/(c^2 + d^2), (b*c - a*d)/(c^2 + d^2)]
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
