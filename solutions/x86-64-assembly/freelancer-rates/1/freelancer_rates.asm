; Everything that comes after a semicolon (;) is a comment.

section .rodata

hours_per_day:   dq 8.0
percent:         dq 0.01
one:             dq 1.0
hours_per_month: dq 176.0

section .text

; You should implement functions in the .text section.
; A skeleton is provided for the first function.

; The global directive makes a function visible to the test files.
global daily_rate
daily_rate:
    vmulsd xmm0, [rel hours_per_day]
    ret

global apply_discount
apply_discount:
    vmovsd xmm2, [rel one]
    vfnmadd132sd xmm1, xmm2, [rel percent]
    vmulsd xmm0, xmm1
    ret
    
global monthly_rate
monthly_rate:
    vmulsd xmm0, [rel hours_per_month]
    vmovsd xmm2, [rel one]
    vfnmadd132sd xmm1, xmm2, [rel percent]
    vmulsd xmm0, xmm1
    vcvtsd2si rax, xmm0, {ru-sae}
    ret

global days_in_budget
days_in_budget:
    vmulsd xmm0, [rel hours_per_day]
    vmovsd xmm2, [rel one]
    vfnmadd132sd xmm1, xmm2, [rel percent]
    vmulsd xmm0, xmm1
    vcvtsi2sd xmm2, rdi
    vdivsd xmm0, xmm2, xmm0
    vcvttsd2si eax, xmm0
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif