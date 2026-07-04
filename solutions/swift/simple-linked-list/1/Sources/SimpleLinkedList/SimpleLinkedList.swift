final class Element<T> {
    var value: T?
    var next: Element?

    init() {}

    init(_ value: T?, _ next: Element?) {
        self.value = value
        self.next = next
    }

    func toArray() -> [T] {
        var values = [T]()
        var current: Element? = self

        while current != nil {
            if let value = current?.value {
                values.append(value)
            }

            current = current?.next
        }

        return values
    }

    func reverseElements() -> Element {
        var current: Element? = self
        var previous: Element?
        var nextNode: Element?

        while current != nil {
            nextNode = current?.next
            current?.next = previous
            previous = current
            current = nextNode
        }

        return previous ?? Element()
    }

    static func fromArray(_ array: [T]) -> Element {
        let list = array.reversed().reduce(nil) { (result, value) in
            Element(value, result)
        }

        return list ?? Element()
    }
}