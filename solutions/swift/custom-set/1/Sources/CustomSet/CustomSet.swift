struct CustomSet<Element: Comparable>: Equatable {

    private var elements: [Element]

    init(_ elements: [Element]) {
        var unique: [Element] = []
        for element in elements where !unique.contains(element) {
            unique.append(element)
        }

        self.elements = unique
    }

    var isEmpty: Bool {
        elements.isEmpty
    }

    func contains(_ element: Element) -> Bool {
        elements.contains(element)
    }

    func isSubset(of set: CustomSet) -> Bool {
        intersection(set).elements.count == elements.count
    }

    func isDisjoint(with set: CustomSet) -> Bool {
        intersection(set).isEmpty
    }

    static func == (lhs: CustomSet, rhs: CustomSet) -> Bool {
        lhs.elements.sorted() == rhs.elements.sorted()
    }

    mutating func add(_ element: Element) {
        guard !elements.contains(element) else {
            return
        }

        elements.append(element)
    }

    func intersection(_ set: CustomSet) -> CustomSet {
        CustomSet(elements.filter { set.contains($0) })
    }

    func difference(_ set: CustomSet) -> CustomSet {
        CustomSet(elements.filter { !set.contains($0) })
    }

    func union(_ set: CustomSet) -> CustomSet {
        CustomSet(set.elements + difference(set).elements)
    }
}