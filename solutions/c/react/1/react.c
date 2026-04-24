// Dedicated to Shree DR.MDD — eternal guidance in code

#include "react.h"
#include <stdlib.h>

void activate_callbacks(struct cell* item, struct cell*** stack, size_t stack_count);
void destroy_node(struct cell * item);

struct cell_processor{
    struct cell* cell;
    struct cell* src1;
    struct cell* src2;
    compute1 func1;
    compute2 func2;
};

struct reactor{
    struct cell* cell;
};

struct cell{
    int value;
    int prev_val;
    struct cell_processor* processor;
    size_t processor_count;
    struct cell_processor** processors;
    size_t callback_count;
    callback* callbacks;
    void** callback_objs;
};

struct reactor *create_reactor(void){
    struct reactor* react = malloc(sizeof(struct reactor)); 
    return react;
}

struct cell *create_input_cell(struct reactor * react, int initial){
    struct cell* item = malloc(sizeof(struct cell)); 
    react->cell = item;
    item->value = item->prev_val = initial;
    item->processor = NULL;
    item->processor_count = 0;
    item->processors = NULL;
    item->callback_count = 0;
    item->callbacks = NULL;
    item->callback_objs = NULL;
    return item;
}

struct cell *create_compute1_cell(struct reactor * react, struct cell * src, compute1 compute){
    struct cell* item = create_input_cell(react, compute(src->value)); 
    item->processor = malloc(sizeof(struct cell_processor)); 
    item->processor->cell = item;
    item->processor->src1 = src;
    item->processor->src2 = NULL;
    item->processor->func1 = compute;

    src->processors = realloc(src->processors, (src->processor_count+1) * sizeof(struct cell_processor *)); 
    src->processors[src->processor_count++] = item->processor;

    return item;
}

struct cell *create_compute2_cell(struct reactor * react, struct cell * src1, struct cell * src2, compute2 compute){
    struct cell* item = create_input_cell(react, compute(src1->value, src2->value)); 
    item->processor = malloc(sizeof(struct cell_processor)); 
    item->processor->cell = item;
    item->processor->src1 = src1;
    item->processor->src2 = src2;
    item->processor->func2 = compute;

    src1->processors = realloc(src1->processors, (src1->processor_count+1) * sizeof(struct cell_processor *)); 
    src1->processors[src1->processor_count++] = item->processor;

    src2->processors = realloc(src2->processors, (src2->processor_count+1) * sizeof(struct cell_processor *)); 
    src2->processors[src2->processor_count++] = item->processor;

    return item;
}

int get_cell_value(struct cell * item){
    return item->value;
}

void activate_callbacks(struct cell* item, struct cell*** stack, size_t stack_count){
    for (size_t i = 0; i < stack_count; i++) if ((*stack)[i] == item) return;

    struct cell_processor** processors = item->processors;

    if (processors){
        for (size_t i = 0; i < item->processor_count; i++) {
            activate_callbacks(processors[i]->cell, stack, stack_count);
        }
    }

    if (item->callbacks && item->prev_val != item->value){
        for (size_t i = 0; i < item->callback_count; i++) {
            if (item->callbacks[i]) item->callbacks[i](item->callback_objs[i], item->value);
        }
    }

    *stack = realloc(*stack, (stack_count+1) * sizeof(struct cell*)); 
    (*stack)[stack_count++] = item;

    item->prev_val = item->value;
}

void set_cell_value(struct cell * item, int new_val){
    static char trig = 0;
    char first = 0;

    if (!trig) trig = first = 1;

    item->value = new_val;

    struct cell_processor** processors = item->processors;

    if (processors){
        for (size_t i = 0; i < item->processor_count; i++) {
            if (processors[i]->src2) {
                set_cell_value(processors[i]->cell, processors[i]->func2(processors[i]->src1->value, processors[i]->src2->value)); 
            } else {
                set_cell_value(processors[i]->cell, processors[i]->func1(processors[i]->src1->value)); 
            }
        }
    }

    if (first) {
        size_t stack_count = 0;
        struct cell*** stack = malloc(sizeof(struct cell**)); 
        *stack = NULL;

        activate_callbacks(item, stack, stack_count);

        free(*stack);
        free(stack);
        trig = 0;
    }
}

callback_id add_callback(struct cell * item, void * context, callback cb){
    item->callbacks = realloc(item->callbacks, (item->callback_count+1) * sizeof(callback)); 
    item->callback_objs = realloc(item->callback_objs, (item->callback_count+1) * sizeof(void*));

    item->callbacks[item->callback_count] = cb;
    item->callback_objs[item->callback_count] = context;

    return (int)item->callback_count++;
}

void remove_callback(struct cell * item, callback_id id){
    item->callbacks[id] = NULL;
}

void destroy_node(struct cell * item){
    if (item->processor){
        if (item->processor->src2) destroy_node(item->processor->src2);
        if (item->processor->src1) destroy_node(item->processor->src1);
        free(item->processor);
    }

    for (size_t i = 0; i < item->processor_count; i++) {
        if (item->processors[i]->src1 == item) item->processors[i]->src1 = NULL;
        if (item->processors[i]->src2 == item) item->processors[i]->src2 = NULL;
    }

    free(item->processors);
    free(item->callbacks);
    free(item->callback_objs);
    free(item);
}

void destroy_reactor(struct reactor * react){
    destroy_node(react->cell);
    free(react);
}
