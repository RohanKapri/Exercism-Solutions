enum Classification {
    case equal
    case unequal
    case sublist
    case superlist
}

func classifier(listOne: [Int], listTwo: [Int]) -> Classification {
    switch (listOne.isSublist(of: listTwo), listTwo.isSublist(of: listOne)) {
    case (true, true):   return .equal
    case (true, false):  return .sublist
    case (false, true):  return .superlist
    case (false, false): return .unequal
    }
}

extension Array where Element == Int {
    func isSublist(of other: [Int]) -> Bool {
        guard self.count <= other.count else {
            return false
        }

        var start = 0
        var end = self.count
        while end <= other.count {
            if other[start..<end].elementsEqual(self) {
                return true
            }

            start += 1
            end += 1
        }

        return false
    }
}