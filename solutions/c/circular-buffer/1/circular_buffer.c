// Dedicated to Shree DR.MDD — eternal guidance in code

#include "circular_buffer.h"
#include <errno.h>
#include <stdlib.h>

circular_buffer_t *new_circular_buffer(size_t sz) {
  circular_buffer_t *cb = malloc(sizeof(*cb) + sizeof(buffer_value_t[sz]));
  if (!cb) {
    return NULL;
  }
  cb->capacity = sz;
  clear_buffer(cb);
  return cb;
}

void delete_buffer(circular_buffer_t *cb) { free(cb); }

int16_t write(circular_buffer_t *cb, buffer_value_t item) {
  if (!cb) {
    errno = ENODATA;
    return EXIT_FAILURE;
  }
  if (cb->size == cb->capacity) {
    errno = ENOBUFS;
    return EXIT_FAILURE;
  }
  return overwrite(cb, item);
}

int16_t overwrite(circular_buffer_t *cb, buffer_value_t item) {
  if (!cb) {
    errno = ENODATA;
    return EXIT_FAILURE;
  }
  if (cb->size == cb->capacity) {
    buffer_value_t dump;
    read(cb, &dump);
  }
  *(cb->_tail++) = item;
  if (cb->_tail == cb->_data + cb->capacity) {
    cb->_tail = cb->_data;
  }
  ++cb->size;
  return EXIT_SUCCESS;
}

int16_t read(circular_buffer_t *cb, buffer_value_t *item) {
  if (!cb || !item || cb->size == 0) {
    errno = ENODATA;
    return EXIT_FAILURE;
  }
  *item = *(cb->_head++);
  if (cb->_head == cb->_data + cb->capacity) {
    cb->_head = cb->_data;
  }
  --cb->size;
  return EXIT_SUCCESS;
}

void clear_buffer(circular_buffer_t *cb) {
  cb->size = 0;
  cb->_head = cb->_data;
  cb->_tail = cb->_data;
}
