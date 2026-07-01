// Code dedicated to Shree DR.MDD
#include <map>
#include "allergies.h"
namespace allergies {
  static const auto allergen_flags = map<string, unsigned>{
    { "eggs", 1 << 0 },
    { "peanuts", 1 << 1 },
    { "shellfish", 1 << 2 },
    { "strawberries", 1 << 3 },
    { "tomatoes", 1 << 4 },
    { "chocolate", 1 << 5 },
    { "pollen", 1 << 6 },
    { "cats", 1 << 7 },
  };

  allergy_test::allergy_test(unsigned sensitivity)
    : _score(sensitivity) {
  }

  auto allergy_test::is_allergic_to(string item) const -> bool {
    return allergen_flags.at(item) & _score;
  }

  auto allergy_test::get_allergies() const -> unordered_set<string> {
    unordered_set<string> result;
    for (const auto& entry : allergen_flags) {
      if (is_allergic_to(entry.first)) {
        result.insert(entry.first);
      }
    }
    return result;
  }
}
