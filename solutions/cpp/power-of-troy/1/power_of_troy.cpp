#include "power_of_troy.h"
auto troy::give_new_artifact(human& h, std::string name) -> void
{
  h.possession = std::make_unique<artifact>(name);
}
auto troy::exchange_artifacts(std::unique_ptr<artifact>& a, std::unique_ptr<artifact>& b) -> void
{
  std::swap(a, b);
}
auto troy::manifest_power(human& h, std::string name) -> void
{
  h.own_power = std::make_shared<power>(name);
}
auto troy::use_power(human& user, human& target) -> void
{
  target.influenced_by = user.own_power;
}
auto troy::power_intensity(human& h) -> int
{
  return h.own_power.use_count();
}
