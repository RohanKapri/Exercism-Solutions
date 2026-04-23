.section .rodata

letter_scores:
    .byte  1 // A
    .byte  3 // B
    .byte  3 // C
    .byte  2 // D
    .byte  1 // E
    .byte  4 // F
    .byte  2 // G
    .byte  4 // H
    .byte  1 // I
    .byte  8 // J
    .byte  5 // K
    .byte  1 // L
    .byte  3 // M
    .byte  1 // N
    .byte  1 // O
    .byte  3 // P
    .byte 10 // Q
    .byte  1 // R
    .byte  1 // S
    .byte  1 // T
    .byte  1 // U
    .byte  4 // V
    .byte  4 // W
    .byte  8 // X
    .byte  4 // Y
    .byte 10 // Z

.text
.globl score

score:
    mov   x1, x0                // Copy input address
    mov   x0, xzr               // Initialize output
    adr   x2, letter_scores     // Load address of letter scores array

.next:
    ldrb  w3, [x1], #1          // Get next input byte
    cbz   w3, .return           // More input letters?
    orr   w3, w3, #32           // Convert English letter to lower case
    sub   w3, w3, #'a'          // Convert to letter score index
    cmp   w3, #25               // Array bounds check (skip non-letters)
    bhi   .next                 // Unsigned > comparison
    ldrb  w4, [x2, x3]          // Get score of current letter
    add   x0, x0, x4            // Add to total word score
    b     .next

.return:
    ret