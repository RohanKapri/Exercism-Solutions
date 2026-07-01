#pragma once
#include <memory>
#include <string>
namespace troy {
  struct artifact {
    artifact(std::string name)
      : name(name)
    {
    }
    std::string name;
  };
  struct power {
    power(std::string effect)
      : effect(effect)
    {
    }
    std::string effect;
  };
  struct human {
    std::unique_ptr<artifact> possession = nullptr;
    std::shared_ptr<power> own_power = nullptr;
    std::shared_ptr<power> influenced_by = nullptr;
  };
  auto give_new_artifact(human& h, std::string name) -> void;
  auto exchange_artifacts(std::unique_ptr<artifact>& a, std::unique_ptr<artifact>& b) -> void;
  auto manifest_power(human& h, std::string name) -> void;
  auto use_power(human& user, human& target) -> void;
  auto power_intensity(human& h) -> int;
}
