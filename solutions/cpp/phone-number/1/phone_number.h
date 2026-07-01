#ifndef PHONE_NUMBER_H
#define PHONE_NUMBER_H
#include <string>
namespace phone_number {
  class phone_number {
   public:
    phone_number(const std::string& number);
    std::string number() const;
    std::string area_code() const;
    std::string exchange_code() const;
    operator std::string() const;
   private:
    std::string _number;
  };
}
#endif
