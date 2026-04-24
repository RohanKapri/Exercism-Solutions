#ifndef INTERGALACTIC_TRANSMISSION_H
#define INTERGALACTIC_TRANSMISSION_H
#include <stdint.h>
#include <stddef.h>
#define WRONG_PARITY -1
int parity_bit(uint8_t bits);
uint8_t getbit(const uint8_t *source, int message_length);
uint8_t getbits(const uint8_t *source, int message_length);
void putbit(const uint8_t bit);
int transmit_sequence(uint8_t *buffer, const uint8_t *message, int message_length);
int decode_message(uint8_t *buffer, const uint8_t *message, int message_length);
#endif