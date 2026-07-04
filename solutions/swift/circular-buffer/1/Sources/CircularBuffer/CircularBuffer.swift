enum CircularBufferError: Error {
    case bufferEmpty
    case bufferFull
}

struct CircularBuffer {
    private let capacity: Int
    private var storage: [Int]
    private var head = 0   // oldest element (read position)
    private var tail = 0   // next write position
    private var count = 0

    init(capacity: Int) {
        self.capacity = capacity
        self.storage = Array(repeating: 0, count: capacity)
    }

    private var isFull: Bool { count == capacity }

    mutating func write(_ element: Int) throws {
        guard !isFull else {
            throw CircularBufferError.bufferFull
        }

        storage[tail] = element
        tail = (tail + 1) % capacity
        count += 1
    }

    mutating func read() throws -> Int {
        guard count > 0 else {
            throw CircularBufferError.bufferEmpty
        }

        let element = storage[head]
        head = (head + 1) % capacity
        count -= 1

        return element
    }

    mutating func overwrite(_ element: Int) {
        let wasFull = isFull
        storage[tail] = element
        tail = (tail + 1) % capacity

        if wasFull {
            head = (head + 1) % capacity
        } else {
            count += 1
        }
    }

    mutating func clear() {
        head = 0
        tail = 0
        count = 0
    }
}