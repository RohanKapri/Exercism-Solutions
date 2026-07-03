enum BinarySearchError: Error {
    case valueNotFound
}
// O(log N)
class BinarySearch {
    private let array: [Int]

    init(_ array: [Int]) {
        self.array = array
    }

    func searchFor(_ value: Int) throws -> Int {
        var lowerBound = 0
        var upperBound = array.count - 1

        while lowerBound <= upperBound {
            let middle = (lowerBound + upperBound) / 2
            let middleValue = array[middle]

            if middleValue == value {
                return middle
            } else if middleValue < value {
                lowerBound = middle + 1
            } else {
                upperBound = middle - 1
            }
        }

        throw BinarySearchError.valueNotFound
    }
}

