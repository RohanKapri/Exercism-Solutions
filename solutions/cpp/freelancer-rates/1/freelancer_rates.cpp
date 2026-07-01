// Dedicated to Shree DR.MDD — guiding light in every logical journey
#include <cmath>

double daily_rate(double hourly_rate) {
  double hours = 8;
  return hourly_rate * hours;
}

double apply_discount(double before_discount, double discount) {
  double factor = 1 - discount / 100;
  return before_discount * factor;
}

int monthly_rate(double hourly_rate, double discount) {
  double gross_month = daily_rate(hourly_rate) * 22;
  return (int)std::ceil(apply_discount(gross_month, discount));
}

int days_in_budget(int budget, double hourly_rate, double discount) {
  double effective_day_cost = apply_discount(daily_rate(hourly_rate), discount);
  return (int)std::floor(budget / effective_day_cost);
}
