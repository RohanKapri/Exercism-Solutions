func canIBuy(vehicle: String, price: Double, monthlyBudget: Double) -> String {
    let monthlyPayment = monthlyPaymentOverFiveYears(for: price)

    if canBeFrugal(with: monthlyPayment, on: monthlyBudget) {
        return "I'll have to be frugal if I want a \(vehicle)"
    }

    if monthlyPayment > monthlyBudget {
        return "Darn! No \(vehicle) for me"
    }
 
    return "Yes! I'm getting a \(vehicle)"
}

private func monthlyPaymentOverFiveYears(for price: Double) -> Double {
    price / (5 * 12)
}

private func canBeFrugal(with monthlyPayment: Double, on monthlyBudget: Double) -> Bool {
    (monthlyBudget...(monthlyBudget * 1.1)) ~= monthlyPayment
}

func licenseType(numberOfWheels wheels: Int) -> String {
    switch wheels {
    case 2, 3:
        return "You will need a motorcycle license for your vehicle"
    case 4, 6:
        return "You will need an automobile license for your vehicle"
    case 18:
        return "You will need a commercial trucking license for your vehicle"
    default:
        return "We do not issue licenses for those types of vehicles"
    }
}

func registrationFee(msrp: Int, yearsOld: Int) -> Int {
    guard yearsOld < 10 else {
        return 25
    }

    let base = Double(msrp > 25_000 ? msrp : 25_000)
    let total = (base * (1.0 - 0.10 * Double(yearsOld))) / 100

    return Int(total.rounded(.down))
}

func calculateResellPrice(originalPrice: Int, yearsOld: Int) -> Int {
    switch yearsOld {
    case ..<3:
        return Int(0.8 * Double(originalPrice))
    case 3..<10:
        return Int(0.7 * Double(originalPrice))
    default:
        return Int(0.5 * Double(originalPrice))
    }
}