import Foundation

func dailyRateFrom(hourlyRate: Int) -> Double {
  return Double(8 * hourlyRate)
}

func monthlyRateFrom(hourlyRate: Int, withDiscount discount: Double) -> Double {
  let monthly = 22 * dailyRateFrom(hourlyRate: hourlyRate)
	let reduceBy = monthly * discount / 100
  return round(monthly - reduceBy)
}

func workdaysIn(budget: Double, hourlyRate: Int, withDiscount discount: Double) -> Double {
	return floor(budget / monthlyRateFrom(hourlyRate: hourlyRate, withDiscount: discount) * 22)
}