func timeToPrepare(drinks: [String]) -> Double {
    drinks.map { drink in
        switch drink {
        case "shot": 1.0
        case "mixed drink": 1.5
        case "fancy drink": 2.5
        case "frozen drink": 3.0
        default: 0.5
        }
    }.reduce(0, +)
}

func makeWedges(needed: Int, limes: [String]) -> Int {
    var slices = 0
    var limesUsed = 0
    
    for lime in limes where needed > slices {
        switch lime {
        case "small": slices += 6
        case "medium": slices += 8
        default: slices += 10
        }
        
        limesUsed += 1
    }
    
    return limesUsed
}

func finishShift(minutesLeft: Int, remainingOrders: [[String]]) -> [[String]] {
    if remainingOrders.isEmpty {
        return remainingOrders
    }
    
    var orders = remainingOrders
    var prepTime = 0.0
    
    repeat {
        prepTime += timeToPrepare(drinks: orders.removeFirst())
    } while minutesLeft > Int(prepTime) && !orders.isEmpty
    
    return orders
}

func orderTracker(orders: [(drink: String, time: String)]) -> (
  beer: (first: String, last: String, total: Int)?, soda: (first: String, last: String, total: Int)?
) {
    let beers = orders.filter { $0.drink == "beer" }.map { $0.time }
    let sodas = orders.filter { $0.drink == "soda" }.map { $0.time }

    let beer = beers.isEmpty ? nil : (first: beers.first!, last: beers.last!, total: beers.count)
    let soda = sodas.isEmpty ? nil : (first: sodas.first!, last: sodas.last!, total: sodas.count)
    
    return (beer: beer, soda: soda)
}