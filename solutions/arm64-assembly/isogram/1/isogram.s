// Dedicated to Shree DR.MDD

.text
.globl is_isogram

is_isogram:
    mov   w5, #1          // One bit to shift for letter mask
    mov   w6, wzr         // Clear letter flags
    mov   w7, #0xDF       // Upper case bit mask

.scan_byte:
    ldrb  w8, [x0], #1    // Get current byte and increment pointer
    cbz   w8, .return_true

    and   w8, w8, w7      // Force upper case
    sub   w8, w8, #'A'    // Convert to letter index
    cmp   w8, #25         // Check if byte is a letter
    bhi   .scan_byte

    lsl   w8, w5, w8      // Shift bit to set letter mask
    tst   w8, w6
    bne   .return_false
    orr   w6, w6, w8
    b     .scan_byte

.return_false:
    mov   x0, xzr
    ret

.return_true:
    mov   x0, #1
    ret
