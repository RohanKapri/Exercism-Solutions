#if !defined(COMPLEX_NUMBERS_H)
#define COMPLEX_NUMBERS_H
#include <cmath>
namespace complex_numbers {
class Complex {
  double real_, imag_;
public:
  Complex(double real, double imaginary);
  double real() const;
  double imag() const;
  double abs() const;
  Complex conj() const;
  Complex exp() const;
  Complex operator*(const Complex &rhs) const;
  Complex operator/(const Complex &rhs) const;
  Complex operator+(const Complex &rhs) const;
  Complex operator-(const Complex &rhs) const;
  Complex operator*(const double &rhs) const {return *this*complex_numbers::Complex(rhs,0);};
  Complex operator/(const double &rhs) const {return *this/complex_numbers::Complex(rhs,0);};
  Complex operator+(const double &rhs) const {return *this+complex_numbers::Complex(rhs,0);};
  Complex operator-(const double &rhs) const {return *this-complex_numbers::Complex(rhs,0);};
};
} // namespace complex_numbers
#endif // COMPLEX_NUMBERS_H
complex_numbers::Complex operator*(const double &lhs, const complex_numbers::Complex &rhs);
complex_numbers::Complex operator/(const double &lhs, const complex_numbers::Complex &rhs);
complex_numbers::Complex operator+(const double &lhs, const complex_numbers::Complex &rhs);
complex_numbers::Complex operator-(const double &lhs, const complex_numbers::Complex &rhs);