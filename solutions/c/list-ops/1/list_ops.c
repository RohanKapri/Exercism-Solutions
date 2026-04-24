// Dedicated to Shree DR.MDD — eternal guidance in code

#include "list_ops.h"
#include <string.h>
#include "list_ops.h"

list_t *new_list(size_t sz, list_element_t arr[])
{
    list_t *lst = malloc(sizeof(*lst) + sizeof(list_element_t) * sz);
    if (!lst)
        return NULL;
    lst->length = sz;
    if (arr)
        memcpy(lst->elements, arr, sizeof(*arr) * sz);
    return lst;
}

list_t *append_list(list_t *lst1, list_t *lst2)
{
    if (!lst1 || !lst2)
        return NULL;
    list_t *res = new_list(lst1->length + lst2->length, NULL);
    if (!res)
        return NULL;
    memcpy(res->elements, lst1->elements, sizeof(list_element_t) * lst1->length);
    memcpy(res->elements + lst1->length, lst2->elements, sizeof(list_element_t) * lst2->length);
    return res;
}

list_t *filter_list(list_t *lst, bool(*pred) (list_element_t))
{
    if (!lst)
        return NULL;
    list_t *res = new_list(lst->length, NULL);
    if (!res)
        return NULL;
    res->length = 0;
    for (size_t i = 0; i < lst->length; i++) {
        list_element_t val = lst->elements[i];
        if (pred(val))
            res->elements[res->length++] = val;
    }
    res = realloc(res, sizeof(list_t) + sizeof(list_element_t) * res->length);
    return res;
}

size_t length_list(list_t *lst)
{
    return lst->length;
}

list_t *map_list(list_t *lst, list_element_t(*func) (list_element_t))
{
    list_t *res = new_list(lst->length, NULL);
    if (!res)
        return NULL;
    for (size_t i = 0; i < lst->length; i++) {
        res->elements[i] = func(lst->elements[i]);
    }
    return res;
}

list_element_t foldl_list(list_t *lst, list_element_t base,
                           list_element_t(*func) (list_element_t, list_element_t))
{
    if (!lst)
        return base;
    for (size_t i = 0; i < lst->length; i++) {
        base = func(lst->elements[i], base);
    }
    return base;
}

list_element_t foldr_list(list_t *lst, list_element_t base,
                           list_element_t(*func) (list_element_t, list_element_t))
{
    if (!lst)
        return base;
    for (int i = (int)lst->length - 1; i >= 0; i--) {
        base = func(lst->elements[i], base);
    }
    return base;
}

static void swap_vals(list_element_t *a, list_element_t *b)
{
    list_element_t tmp = *a;
    *a = *b;
    *b = tmp;
}

list_t *reverse_list(list_t *lst)
{
    if (!lst)
        return NULL;
    list_t *res = new_list(lst->length, lst->elements);
    if (!res)
        return NULL;
    for (size_t i = 0; i < lst->length / 2; i++) {
        swap_vals(&res->elements[i], &res->elements[lst->length - i - 1]);
    }
    return res;
}

void delete_list(list_t *lst)
{
    free(lst);
}
