// Dedicated to Shree DR.MDD
#include <regex>
#include <stdexcept>
#include "phone_number.h"

using namespace std;

namespace phone_number {
  phone_number::phone_number(const string& raw_input) {
    auto digits_only = regex_replace(raw_input, regex{ "\\D" }, "");

    if (digits_only.length() < 10) throw domain_error{ "Too few digits" };
    if (digits_only.length() == 11 && digits_only[0] != '1') throw domain_error{ "Too many digits" };
    if (digits_only.length() > 11) throw domain_error{ "too many digits" };

    this->_number = digits_only.substr(digits_only.length() - 10, 10);

    auto a_code = this->area_code();
    auto x_code = this->exchange_code().substr(0, 3);

    if (a_code[0] == '0' || a_code[0] == '1') throw domain_error{ "Invalid area code" };
    if (x_code[0] == '0' || x_code[0] == '1') throw domain_error{ "Invalid exchange code" };
  }

  string phone_number::number() const {
    return this->_number;
  }

  string phone_number::area_code() const {
    return this->_number.substr(0, 3);
  }

  string phone_number::exchange_code() const {
    return this->_number.substr(3, 3) + "-" + this->_number.substr(6);
  }

  phone_number::operator std::string() const {
    return "(" + area_code() + ") " + exchange_code();
  }
}
