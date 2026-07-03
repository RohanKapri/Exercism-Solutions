func remainingMinutesInOven(elapsedMinutes: Int, expectedMinutesInOven: Int = 40) -> Int {
    expectedMinutesInOven - elapsedMinutes
}

func preparationTimeInMinutes(layers: String...) -> Int {
    layers.count * 2
}

func quantities(layers: String...) -> (noodles: Int, sauce: Double) {
    let noodleLayers = layers.filter { $0 == "noodles" }.count
    let sauceLayers = layers.filter { $0 == "sauce" }.count
    
    return (noodles: noodleLayers * 3, sauce: Double(sauceLayers) * 0.2)
}

func toOz(_ quantities: inout (noodles: Int, sauce: Double)) {
    quantities.sauce *= 33.814
}

func redWine(layers: String...) -> Bool {
    func mozzarellaLayers() -> Int {
        layers.filter { $0 == "mozzarella" }.count
    }
    
    func ricottaLayers() -> Int {
        layers.filter { $0 == "ricotta" }.count
    }
    
    func béchamelLayers() -> Int {
        layers.filter { $0 == "béchamel" }.count
    }
    
    func sauceLayers() -> Int {
        layers.filter { $0 == "sauce" }.count
    }
    
    func meatLayers() -> Int {
        layers.filter { $0 == "meat" }.count
    }
    
    return mozzarellaLayers() + ricottaLayers() + béchamelLayers() <= sauceLayers() + meatLayers()
}