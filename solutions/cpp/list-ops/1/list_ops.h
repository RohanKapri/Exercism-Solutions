#pragma once
#include <functional>
#include <vector>
namespace list_ops {
  template <typename T>
  auto append(std::vector<T>& left, const std::vector<T>& right) -> void
  {
    left.insert(left.end(), right.begin(), right.end());
  }
  template <typename T>
  auto concat(const std::vector<std::vector<T>>& lists) -> std::vector<T>
  {
    auto result = std::vector<T>{};
    for(const auto& list : lists) {
      result.insert(result.end(), list.begin(), list.end());
    }
    return result;
  }
  template <typename T, typename F>
  auto filter(const std::vector<T>& list, F&& predicate) -> std::vector<T>
  {
    auto result = std::vector<T>{};
    for(const auto& element : list) {
      if(predicate(element)) {
        result.emplace_back(element);
      }
    }
    return result;
  }
  template <typename T>
  auto length(const std::vector<T>& list) -> size_t
  {
    auto result = size_t{ 0 };
    for(const auto& _ : list) {
      (void)_;
      ++result;
    }
    return result;
  }
  template <typename T, typename F>
  auto map(const std::vector<T>& list, F&& f) -> std::vector<T>
  {
    auto result = std::vector<T>{};
    for(const auto& element : list) {
      result.emplace_back(f(element));
    }
    return result;
  }
  template <typename T, typename F>
  auto foldl(const std::vector<T>& list, T init, F&& f) -> T
  {
    auto acc = init;
    for(const auto& element : list) {
      acc = f(acc, element);
    }
    return acc;
  }
  template <typename T, typename F>
  auto foldr(const std::vector<T>& list, T init, F&& f) -> T
  {
    auto acc = init;
    for(auto it = list.rbegin(); it != list.rend(); ++it) {
      acc = f(acc, *it);
    }
    return acc;
  }
  template <typename T>
  auto reverse(const std::vector<T>& list) -> std::vector<T>
  {
    auto result = std::vector<T>{};
    for(auto it = list.rbegin(); it != list.rend(); ++it) {
      result.emplace_back(*it);
    }
    return result;
  }
}
