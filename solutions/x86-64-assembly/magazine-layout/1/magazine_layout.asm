%ifndef MAGAZINE_LAYOUT_ASM
%define MAGAZINE_LAYOUT_ASM

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; --- Task 1: name the format constants ---
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

COLUMN_COUNT  equ 4
COLUMN_STRIDE equ 18
SPACE         equ 0x20
RULE          equ 0x3D
RULE_WIDTH    equ 4
PLAIN         equ 0x2E
RULED         equ 0x2D
BOXED         equ 0x23

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; --- Task 2: define the COUNTER and the fill_run macros ---
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%define COUNTER rcx

%macro fill_run 3
    xor COUNTER, COUNTER
%%loop:
    cmp COUNTER, %2
    jae %%done
    mov byte [%1 + COUNTER], %3
    inc COUNTER
    jmp %%loop
%%done:
%endmacro

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; --- Task 3: define the lay_columns macro ---
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%macro lay_columns 2
%assign i 0
%rep COLUMN_COUNT
    mov qword [%1 + i * 8], %2
    add %2, COLUMN_STRIDE
%assign i i + 1
%endrep
%endmacro

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; --- Task 4: define the set_header macro ---
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%macro set_header 2
%if %2 = 0
    mov byte [%1], PLAIN
%elif %2 = 1
    mov byte [%1], RULED
%elif %2 = 2
    mov byte [%1], BOXED
%endif
%endmacro

%endif

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif