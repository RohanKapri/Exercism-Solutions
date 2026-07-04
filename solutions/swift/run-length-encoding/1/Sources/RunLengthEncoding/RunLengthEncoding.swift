struct RunLengthEncoding {
    static func encode(_ data: String) -> String {
        var result = ""
        var count = 1

        for (current, next) in zip(data, data.dropFirst()) {
            if current == next {
                count += 1
            } else {
                if count > 1 {
                    result.append("\(count)")
                }

                result.append(current)
                count = 1
            }
        }

        if let last = data.last {
            if count > 1 {
                result.append("\(count)")
            }

            result.append(last)
        }

        return result
    }

    static func decode(_ data: String) -> String {
        var result = ""
        var count = 0

        for character in data {
            if let n = character.wholeNumberValue {
                count = (10 * count) + n
            } else {
                result.append(String(repeating: character, count: max(count, 1)))
                count = 0
            }
        }

        return result
    }
}