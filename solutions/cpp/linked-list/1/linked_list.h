#pragma once
#include <memory>
namespace linked_list {
  template <typename T>
  class List {
   private:
    class Node {
     public:
      Node(T value)
        : value(value)
      {
      }
      T value;
      std::shared_ptr<Node> next;
      std::shared_ptr<Node> prev;
    };
   public:
    ~List()
    {
      auto node = head;
      while(node) {
        node->prev = nullptr;
        node = node->next;
      }
    }
    auto push(T value) -> void
    {
      if(head == nullptr) {
        head = tail = std::make_shared<Node>(value);
      }
      else {
        auto node = std::make_shared<Node>(value);
        tail->next = node;
        node->prev = tail;
        tail = node;
      }
    }
    auto pop() -> T
    {
      auto value = tail->value;
      tail = tail->prev;
      (tail ? tail->next : head) = nullptr;
      return value;
    }
    auto unshift(T value) -> void
    {
      if(head == nullptr) {
        head = tail = std::make_shared<Node>(value);
      }
      else {
        auto node = std::make_shared<Node>(value);
        node->next = head;
        head = node;
      }
    }
    auto shift() -> T
    {
      auto value = head->value;
      head = head->next;
      (head ? head->prev : tail) = nullptr;
      return value;
    }
    auto erase(T value) -> void
    {
      auto node = head;
      while(node) {
        if(node->value == value) {
          if(node == head) {
            head = node->next;
            if(head) {
              head->prev = nullptr;
            }
          }
          else if(node == tail) {
            tail = node->prev;
            if(tail) {
              tail->next = nullptr;
            }
          }
          else {
            node->prev->next = node->next;
            node->next->prev = node->prev;
          }
          return;
        }
        node = node->next;
      }
    }
    auto count() -> size_t
    {
      auto count = size_t{ 0 };
      auto node = head;
      while(node) {
        count++;
        node = node->next;
      }
      return count;
    }
   private:
    std::shared_ptr<Node> head;
    std::shared_ptr<Node> tail;
  };
}
