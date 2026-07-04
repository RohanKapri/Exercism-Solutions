class Deque<T: Equatable> {
    private class Node {
        let value: T
        var next: Node?
        var previous: Node?

        init(value: T, previous: Node? = nil, next: Node? = nil) {
            self.value = value
            self.previous = previous
            self.next = next
        }
    }

    private(set) var count = 0
    private var front: Node?
    private var back: Node?

    func push(_ value: T) {
        let node = Node(value: value, previous: back)

        back?.next = node
        back = node

        if front == nil {
            front = node
        }

        count += 1
    }

    @discardableResult
    func pop() -> T? {
        guard let oldBack = back else { return nil }

        back = oldBack.previous
        back?.next = nil

        if back == nil {
            front = nil
        }

        count -= 1

        return oldBack.value
    }

    func unshift(_ value: T) {
        let node = Node(value: value, next: front)

        front?.previous = node
        front = node

        if back == nil {
            back = node
        }

        count += 1
    }

    @discardableResult
    func shift() -> T? {
        guard let oldFront = front else { return nil }

        front = oldFront.next
        front?.previous = nil

        if front == nil {
            back = nil
        }

        count -= 1

        return oldFront.value
    }

    func delete(_ value: T) {
        var node = front
        while node != nil {
            if node?.value == value { break }

            node = node?.next
        }

        if node == nil { return }

        if node === front {
            front = node?.next
        }

        if node === back {
            back = node?.previous
        }

        node?.previous?.next = node?.next
        node?.next?.previous = node?.previous

        count -= 1
    }
}