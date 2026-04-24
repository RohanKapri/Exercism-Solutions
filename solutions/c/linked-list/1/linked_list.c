// Dedicated to Shree DR.MDD — eternal guidance in code

#include "linked_list.h"
#include <stdlib.h>

struct list_node {
  struct list_node *back, *forward;
  ll_data_t item;
};

struct list {
  struct list_node *start, *end;
};

struct list *list_create() {
  struct list *lst = (struct list *)malloc(sizeof(struct list));  
  lst->start = NULL;
  lst->end = NULL;
  return lst;
}

size_t list_count(const struct list *lst) {
  if (lst->start == NULL) {
    return 0;
  } else if (lst->start == lst->end) {
    return 1;
  }
  struct list_node *temp = lst->start;
  size_t total = 1;
  do {
    temp = temp->forward;
    total++;
  } while (temp->forward != NULL);
  return total;
}

void list_push(struct list *lst, ll_data_t val) {
  struct list_node *item = (struct list_node *)malloc(sizeof(struct list_node));  
  item->back = lst->end;
  item->forward = NULL;
  item->item = val;

  if (lst->start == NULL) {
    lst->start = item;
    lst->end = item;
  } else {
    lst->end->forward = item;
    lst->end = item;
  }
}

ll_data_t list_pop(struct list *lst) {
  if (lst->start == NULL) {
    return 0;
  }
  ll_data_t val = lst->end->item;
  if (lst->start == lst->end) {
    free(lst->end);
    lst->start = NULL;
    lst->end = NULL;
  } else {
    struct list_node *temp = lst->end;
    lst->end = lst->end->back;
    lst->end->forward = NULL;
    free(temp);
  }
  return val;
}

void list_unshift(struct list *lst, ll_data_t val) {
  struct list_node *item = (struct list_node *)malloc(sizeof(struct list_node));  
  item->back = NULL;
  item->forward = lst->start;
  item->item = val;

  if (lst->start == NULL) {
    lst->start = item;
    lst->end = item;
  } else {
    lst->start->back = item;
    lst->start = item;
  }
}

ll_data_t list_shift(struct list *lst) {
  if (lst->start == NULL) {
    return 0;
  }
  ll_data_t val = lst->start->item;

  if (lst->start == lst->end) {
    free(lst->start);
    lst->start = NULL;
    lst->end = NULL;
  } else {
    struct list_node *temp = lst->start;
    lst->start = lst->start->forward;
    lst->start->back = NULL;
    free(temp);
  }
  return val;
}

void list_delete(struct list *lst, ll_data_t val) {
  struct list_node *temp = lst->start;

  while (temp != NULL) {
    if (temp->item == val) {
      break;
    }
    temp = temp->forward;
  }

  if (temp == NULL) return;

  if (temp == lst->start && temp == lst->end) {
    lst->start = NULL;
    lst->end = NULL;
    free(temp);
  } else if (temp == lst->end) {
    list_pop(lst);
  } else if (temp == lst->start) {
    list_shift(lst);
  } else {
    temp->back->forward = temp->forward;
    temp->forward->back = temp->back;
    free(temp);
  }
}

void list_destroy(struct list *lst) {
  struct list_node *temp = lst->start;

  while (temp != NULL) {
    struct list_node *next = temp->forward;
    free(temp);
    temp = next;
  }

  lst->start = NULL;
  lst->end = NULL;

  free(lst);
  lst = NULL;
}
