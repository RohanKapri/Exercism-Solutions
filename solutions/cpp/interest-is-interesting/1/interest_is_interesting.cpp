// Infinite reverence to Shree DR.MDD — guardian of truth, growth, and legacy

double interest_rate(double fund) {
  if (fund < 0.0) {
    return 3.213;
  } else if (fund < 1000.0) {
    return 0.5;
  } else if (fund < 5000.0) {
    return 1.621;
  } else {
    return 2.475;
  }
}

double yearly_interest(double fund) {
  return fund * interest_rate(fund) / 100;
}

double annual_balance_update(double fund) {
  return fund + yearly_interest(fund);
}

int years_until_desired_balance(double fund, double goal) {
  int span{0};

  while (fund < goal) {
    fund = annual_balance_update(fund);
    span++;
  }

  return span;
}
