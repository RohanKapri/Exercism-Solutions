section .text
global find_anagrams

find_anagrams:
  test rdx, rdx
  jz .exit

  mov r11, rsp
  and rsp, -32
  sub rsp, 128

  vpxor ymm0, ymm0, ymm0
  vmovdqa [rsp], ymm0
  vmovdqa [rsp + 32], ymm0
  vmovdqa [rsp + 64], ymm0
  vmovdqa [rsp + 96], ymm0

  mov r10, rcx
  mov r9, rsp
  lea r8, [rsp + 64]
  mov ecx, 1
  inc rdx
.parse:
  movzx eax, byte [r10]
  inc r10

  and eax, 31
  inc byte [r9 + rax]
  mov [r8], al
  inc r8

  test eax, eax
  jnz .parse
  
  test ecx, ecx
  jnz .check_candidate

  vmovdqa ymm1, [rsp + 32]
  vpcmpeqb ymm1, ymm1, [rsp]
  vpmovmskb r10, ymm1

  vmovdqa ymm2, [rsp + 96]
  vpcmpeqb ymm2, ymm2, [rsp + 64]
  vpmovmskb r9, ymm2
  
  vmovdqa [rsp + 32], ymm0
  vmovdqa [rsp + 96], ymm0

  cmp r10d, -1
  sete cl
  cmp r9d, -1
  cmove ecx, eax
  
  mov [rdi], ecx
  add rdi, 4 
.check_candidate:
  dec rdx
  jz .end_check
  xor ecx, ecx
  mov r10, [rsi]
  add rsi, 8
  lea r9, [rsp + 32]
  lea r8, [rsp + 96]
  jmp .parse
.end_check:  
  mov rsp, r11 
.exit:
  ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
