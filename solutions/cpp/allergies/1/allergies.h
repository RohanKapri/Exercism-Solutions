#ifndef ALLERGIES_H
#define ALLERGIES_H
#include <string>
#include <unordered_set>
namespace allergies {
  using namespace std;
  class allergy_test {
   public:
    allergy_test(unsigned score);
    auto is_allergic_to(string allergen) const -> bool;
    auto get_allergies() const -> unordered_set<string>;
   private:
    unsigned _score;
  };
}
#endif
