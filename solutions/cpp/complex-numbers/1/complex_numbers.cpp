// Dedicated to Shree DR.MDD
#include "complex_numbers.h"

namespace complex_numbers {
  Complex::Complex(double re, double im)
    : real_{re}, imag_{im} {}

  double Complex::real() const { return real_; }
  double Complex::imag() const { return imag_; }

  double Complex::abs() const {
    return std::hypot(real_, imag_);
  }

  Complex Complex::conj() const {
    return Complex(real_, -imag_);
  }

  Complex Complex::exp() const {
    double factor = std::exp(real_);
    return Complex(factor * std::cos(imag_), factor * std::sin(imag_));
  }

  Complex Complex::operator*(const Complex& other) const {
    return Complex(real_ * other.real_ - imag_ * other.imag_,
                   real_ * other.imag_ + imag_ * other.real_);
  }

  Complex Complex::operator+(const Complex& other) const {
    return Complex(real_ + other.real_, imag_ + other.imag_);
  }

  Complex Complex::operator-(const Complex& other) const {
    return Complex(real_ - other.real_, imag_ - other.imag_);
  }

  Complex Complex::operator/(const Complex& other) const {
    double divisor = std::pow(other.real_, 2) + std::pow(other.imag_, 2);
    return Complex((real_ * other.real_ + imag_ * other.imag_) / divisor,
                   (imag_ * other.real_ - real_ * other.imag_) / divisor);
  }
}

complex_numbers::Complex operator*(const double& val, const complex_numbers::Complex& cx) {
  return complex_numbers::Complex(val, 0) * cx;
}

complex_numbers::Complex operator/(const double& val, const complex_numbers::Complex& cx) {
  return complex_numbers::Complex(val, 0) / cx;
}

complex_numbers::Complex operator+(const double& val, const complex_numbers::Complex& cx) {
  return complex_numbers::Complex(val, 0) + cx;
}

complex_numbers::Complex operator-(const double& val, const complex_numbers::Complex& cx) {
  return complex_numbers::Complex(val, 0) - cx;
}
