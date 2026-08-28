.text
.globl format

// -------------------------------------------------------------------------
// format: Formats the customer greeting sentence into a target buffer.
//
// Arguments (ARM64 standard calling convention):
//   x0 - Pointer to the destination buffer (output)
//   x1 - Pointer to the name string (null-terminated)
//   x2 - Customer number (integer between 1 and 999, passed as a register)
// -------------------------------------------------------------------------
format:
    // Move base parameters to scratch registers so we can safely advance pointers
    mov  x9, x0          // x9  = current destination buffer pointer
    mov  x10, x1         // x10 = name string pointer
    mov  w11, w2         // w11 = customer number (32-bit)

// Step 1: Copy the Name string to the buffer
copy_name:
    ldrb w12, [x10], #1  // Load byte from name and post-increment pointer
    cbz  w12, add_comma  // If byte is 0 (null terminator), branch out
    strb w12, [x9], #1   // Store byte into destination buffer and post-increment
    b    copy_name

add_comma:
    // Step 2: Append ", you are the " manually to the buffer
    mov  w12, #44        // ','
    strb w12, [x9], #1
    mov  w12, #32        // ' '
    strb w12, [x9], #1
    mov  w12, #121       // 'y'
    strb w12, [x9], #1
    mov  w12, #111       // 'o'
    strb w12, [x9], #1
    mov  w12, #117       // 'u'
    strb w12, [x9], #1
    mov  w12, #32        // ' '
    strb w12, [x9], #1
    mov  w12, #97        // 'a'
    strb w12, [x9], #1
    mov  w12, #114       // 'r'
    strb w12, [x9], #1
    mov  w12, #101       // 'e'
    strb w12, [x9], #1
    mov  w12, #32        // ' '
    strb w12, [x9], #1
    mov  w12, #116       // 't'
    strb w12, [x9], #1
    mov  w12, #104       // 'h'
    strb w12, [x9], #1
    mov  w12, #101       // 'e'
    strb w12, [x9], #1
    mov  w12, #32        // ' '
    strb w12, [x9], #1

    // Step 3: Extract digits (Hundreds, Tens, Ones) from the customer number
    // We compute remainder fields manually using sdiv and msub
    mov  w13, #100
    sdiv w14, w11, w13   // w14 = Hundreds digit (w11 / 100)
    msub w15, w14, w13, w11 // w15 = Remainder after hundreds (w11 % 100)

    mov  w13, #10
    sdiv w12, w15, w13   // w12 = Tens digit (w15 / 10)
    msub w3, w12, w13, w15  // w3  = Ones digit (w15 % 10)

    // Flag tracking to skip leading zeros
    mov  w4, #0          // w4 = printed_yet flag

    // Print hundreds digit if it's greater than 0
    cbz  w14, check_tens
    add  w5, w14, #48    // Convert digit integer value to ASCII character
    strb w5, [x9], #1
    mov  w4, #1          // Set printed_yet flag to true

check_tens:
    // Print tens digit if flag is set, or if tens digit itself is greater than 0
    cbnz w4, print_tens
    cbz  w12, print_ones
print_tens:
    add  w5, w12, #48    // Convert to ASCII
    strb w5, [x9], #1

print_ones:
    add  w5, w3, #48     // Convert ones digit to ASCII and write it
    strb w5, [x9], #1

    // Step 4: Rule checking logic for suffixes (st, nd, rd, th)
    // Remember: w15 holds the original (number % 100) remainder
    cmp  w15, #11
    beq  suffix_th
    cmp  w15, #12
    beq  suffix_th
    cmp  w15, #13
    beq  suffix_th

    // Fall back to looking strictly at the individual ones digit (w3)
    cmp  w3, #1
    beq  suffix_st
    cmp  w3, #2
    beq  suffix_nd
    cmp  w3, #3
    beq  suffix_rd
    b    suffix_th

suffix_st:
    mov  w12, #115       // 's'
    strb w12, [x9], #1
    mov  w12, #116       // 't'
    strb w12, [x9], #1
    b    add_tail

suffix_nd:
    mov  w12, #110       // 'n'
    strb w12, [x9], #1
    mov  w12, #100       // 'd'
    strb w12, [x9], #1
    b    add_tail

suffix_rd:
    mov  w12, #114       // 'r'
    strb w12, [x9], #1
    mov  w12, #100       // 'd'
    strb w12, [x9], #1
    b    add_tail

suffix_th:
    mov  w12, #116       // 't'
    strb w12, [x9], #1
    mov  w12, #104       // 'h'
    strb w12, [x9], #1

add_tail:
    // Step 5: Append trailing string template " customer we serve today. Thank you!"
    mov  w12, #32        // ' '
    strb w12, [x9], #1
    mov  w12, #99        // 'c'
    strb w12, [x9], #1
    mov  w12, #117       // 'u'
    strb w12, [x9], #1
    mov  w12, #115       // 's'
    strb w12, [x9], #1
    mov  w12, #116       // 't'
    strb w12, [x9], #1
    mov  w12, #111       // 'o'
    strb w12, [x9], #1
    mov  w12, #109       // 'm'
    strb w12, [x9], #1
    mov  w12, #101       // 'e'
    strb w12, [x9], #1
    mov  w12, #114       // 'r'
    strb w12, [x9], #1
    mov  w12, #32        // ' '
    strb w12, [x9], #1
    mov  w12, #119       // 'w'
    strb w12, [x9], #1
    mov  w12, #101       // 'e'
    strb w12, [x9], #1
    mov  w12, #32        // ' '
    strb w12, [x9], #1
    mov  w12, #115       // 's'
    strb w12, [x9], #1
    mov  w12, #101       // 'e'
    strb w12, [x9], #1
    mov  w12, #114       // 'r'
    strb w12, [x9], #1
    mov  w12, #118       // 'v'
    strb w12, [x9], #1
    mov  w12, #101       // 'e'
    strb w12, [x9], #1
    mov  w12, #32        // ' '
    strb w12, [x9], #1
    mov  w12, #116       // 't'
    strb w12, [x9], #1
    mov  w12, #111       // 'o'
    strb w12, [x9], #1
    mov  w12, #100       // 'd'
    strb w12, [x9], #1
    mov  w12, #97        // 'a'
    strb w12, [x9], #1
    mov  w12, #121       // 'y'
    strb w12, [x9], #1
    mov  w12, #46        // '.'
    strb w12, [x9], #1
    mov  w12, #32        // ' '
    strb w12, [x9], #1
    mov  w12, #84        // 'T'
    strb w12, [x9], #1
    mov  w12, #104       // 'h'
    strb w12, [x9], #1
    mov  w12, #97        // 'a'
    strb w12, [x9], #1
    mov  w12, #110       // 'n'
    strb w12, [x9], #1
    mov  w12, #107       // 'k'
    strb w12, [x9], #1
    mov  w12, #32        // ' '
    strb w12, [x9], #1
    mov  w12, #121       // 'y'
    strb w12, [x9], #1
    mov  w12, #111       // 'o'
    strb w12, [x9], #1
    mov  w12, #117       // 'u'
    strb w12, [x9], #1
    mov  w12, #33        // '!'
    strb w12, [x9], #1
    mov  w12, #0         // Append string terminal '\0' character
    strb w12, [x9]

    ret                  // Safely branch back out to the parent runtime frame