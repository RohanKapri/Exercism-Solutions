class NumberSeries {
  // Write your code for the 'LargestSeriesProduct' exercise in this file.
    private var str: String
    init(_ str: String) { 
        self.str = str        
    }

    func largestProduct(_ window: Int) throws -> Int {
        guard window > 0 else { throw NumberSeriesError.spanIsZeroOrNegative }
        
        let numbers = try str.map({ char in
            guard 
                let charAscii = char.asciiValue, 
                let zeroAscii = Character("0").asciiValue,
                charAscii >= zeroAscii, char.isNumber
            else { throw NumberSeriesError.invalidCharacter }

            return Int(charAscii - zeroAscii)
        })     
        
        guard window <= numbers.count else { throw NumberSeriesError.spanLongerThanInput }
        
        var left = 0
        var right = max(1, window - 1)
        var val = 0
        
        while right != numbers.count { 
            val = max(val, numbers[left...right].reduce(1, *))
            left += 1
            right += 1
        }

        return val
    }
}

enum NumberSeriesError: Error { 
    case invalidCharacter        
    case spanLongerThanInput
    case spanIsZeroOrNegative
}