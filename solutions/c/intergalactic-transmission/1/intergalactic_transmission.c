#include "intergalactic_transmission.h"
uint8_t bit_buffer = 0, number_of_bits = 0;
uint8_t *ptr = NULL;
int parity_bit(uint8_t bits) {
    int counter=0;
    bits >>= 1;
    for (int i=0;i<7;i++) {
        if (bits&1) counter++;
        bits >>= 1;
    }
    if (counter&1) return 1;
    else return 0;
}
uint8_t getbit(const uint8_t *source, int message_length) {
    uint8_t bit = 0;
    if (number_of_bits > 0) {
        bit = ((bit_buffer & 0x80) > 0) ? 1 : 0;
        bit_buffer <<= 1;
        number_of_bits--;
    } else {
        if (ptr<source+message_length) {
            bit_buffer = *ptr++;
            bit = ((bit_buffer & 0x80) > 0) ? 1 : 0;
            bit_buffer <<= 1;
            number_of_bits = 7;
        } else bit = 0;
    }
    return bit;
}
void putbit(const uint8_t bit) {
    if (number_of_bits++ < 7) bit_buffer += bit_buffer + bit;
    else {
        bit_buffer += bit_buffer + bit;
        *(ptr++) = bit_buffer;
        bit_buffer = number_of_bits = 0;
    }
}
uint8_t getbits(const uint8_t *source, int message_length) {
    uint8_t data = 0;
    for (int i=0; i<7; i++) 
        data += data + getbit(source, message_length);
    return data*2;
}
int transmit_sequence(uint8_t *buffer, const uint8_t *message, int message_length) {
    if (message==NULL) return 0;
    ptr=(uint8_t*)message;
    int number_of_bytes;
    if ((message_length * 8) % 7 == 0) number_of_bytes = (message_length * 8) / 7;
    else number_of_bytes = ((message_length * 8) / 7) + 1;
    for (int r=0; r<number_of_bytes; r++) {
        uint8_t bits = getbits(message, message_length);
        int pb = parity_bit(bits);
        bits += pb;
        *(buffer++) = bits;
    }
    return number_of_bytes;
}
int decode_message(uint8_t *buffer, const uint8_t *message, int message_length) {
    if (message==NULL) return 0;
    ptr=(uint8_t*)buffer;
    number_of_bits = bit_buffer = 0;
    for (int i=0; i<message_length; i++) {
        uint8_t c = *(message+i);
        if (parity_bit(c&0xFE)!=(c&0x01)) return -1;
        for (int k=0; k<7; k++) {
            uint8_t bit = ((c&0x80)>0) ? 1 : 0;
            putbit(bit);
            c <<= 1;
        }
    }
    return (ptr-buffer);
}