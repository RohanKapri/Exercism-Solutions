#include "lasagna_master.h"
using namespace std;
auto lasagna_master::preparationTime(const vector<string>& layers, int time) -> int
{
  return layers.size() * time;
}
auto lasagna_master::quantities(const vector<string>& layers) -> amount
{
  auto amount = lasagna_master::amount{};
  for(const auto& layer : layers) {
    if(layer == "noodles") {
      amount.noodles += 50;
    }
    else if(layer == "sauce") {
      amount.sauce += 0.2;
    }
  }
  return amount;
}
auto lasagna_master::addSecretIngredient(
  vector<string>& to,
  const vector<string>& from)
  -> void
{
  to[to.size() - 1] = from[from.size() - 1];
}
auto lasagna_master::addSecretIngredient(
  vector<string>& to,
  const string& secretIngredient)
  -> void
{
  to[to.size() - 1] = secretIngredient;
}
auto lasagna_master::scaleRecipe(const vector<double>& input, int portions) -> vector<double>
{
  auto output = vector<double>{};
  for(const auto& ingredient : input) {
    output.push_back(ingredient * portions / 2);
  }
  return output;
}
