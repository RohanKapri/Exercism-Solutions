struct Knapsack {
    static func maximumValue(_ items: [Item], _ weight: Int) -> Int {

        func calc(_ i: Int, _ capacity: Int) -> Int {
            guard i > 0 && capacity > 0 else {
                return 0
            }
            // stats of current item
            let weight = items[i-1].weight
            let value = items[i-1].value

            if weight > capacity {
                // this item is too heavy, use previous combo
                return calc(i-1, capacity)
            } else {
                // find whats more valuable:
                // previous combo or this item plus best combo we can carry in additon
                return max(
                    calc(i-1, capacity),
                    calc(i-1, capacity - weight) + value
                )
            }
        }

        return calc(items.count, weight)
    }
}