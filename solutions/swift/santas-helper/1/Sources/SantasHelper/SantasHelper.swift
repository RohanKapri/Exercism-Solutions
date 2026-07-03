func getName(_ toy: (name: String, amount: Int)) -> String {
    toy.name
}

func createToy(name: String, amount: Int) -> (name: String, amount: Int) {
    (name: name, amount: amount)
}

func updateQuantity(_ items: [(name: String, amount: Int)], toy: String, amount: Int) -> [(name: String, amount: Int)] {
    items.map { $0.name == toy ? (name: $0.name, amount: amount) : $0 }
}

func addCategory(_ items: [(name: String, amount: Int)], category: String) -> [(name: String, amount: Int, category: String)] {
    items.map { (name: $0.name, amount: $0.amount, category: category) }
}