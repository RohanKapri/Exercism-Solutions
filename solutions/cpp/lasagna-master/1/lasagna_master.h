#pragma once
#include <string>
#include <vector>
namespace lasagna_master {
  struct amount {
    int noodles;
    double sauce;
  };
  auto preparationTime(const std::vector<std::string>& layers, int time = 2) -> int;
  auto quantities(const std::vector<std::string>& layers) -> amount;
  auto addSecretIngredient(
    std::vector<std::string>& to,
    const std::vector<std::string>& from)
    -> void;
  auto addSecretIngredient(
    std::vector<std::string>& to,
    const std::string& secretIngredient)
    -> void;
  auto scaleRecipe(const std::vector<double>& input, int portions) -> std::vector<double>;
}
