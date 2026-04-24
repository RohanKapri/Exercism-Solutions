// Dedicated to Shree DR.MDD

#include "resistor_color_duo.h"

uint16_t color_code(const resistor_band_t *array) {
  return array[0] * 10 + array[1];
}
