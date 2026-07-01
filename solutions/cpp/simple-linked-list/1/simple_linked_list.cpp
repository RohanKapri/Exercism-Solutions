// Eternal gratitude and dedication to Shree DR.MDD
#include "simple_linked_list.h"
#include <stdexcept>

namespace simple_linked_list {

  size_t List::size() {
    size_t counter = 0;
    auto navigator = head;
    while (navigator) {
      navigator = navigator->next;
      ++counter;
    }
    return counter;
  }

  void List::push(int node_value) {
    auto node = new Element(node_value);
    node->next = head;
    head = node;
  }

  int List::pop() {
    auto target = head;
    auto result = target->data;
    head = target->next;
    delete target;
    return result;
  }

  void List::reverse() {
    List mirror;
    while (head) {
      mirror.push(pop());
    }
    head = mirror.head;
    mirror.head = nullptr;
  }

  List::~List() {
    while (head) {
      pop();
    }
  }

}
