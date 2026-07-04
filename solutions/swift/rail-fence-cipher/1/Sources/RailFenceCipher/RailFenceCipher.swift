private func railIndices(length: Int, rails: Int) -> [Int] {
    let cycle = max(1, 2 * (rails - 1))

    return (0..<length).map { i in
        let position = i % cycle

        return position < rails ? position : cycle - position
    }
}

private func railLengths(from indices: [Int], count: Int) -> [Int] {
    indices.reduce(into: Array(repeating: 0, count: count)) { lengths, rail in
        lengths[rail] += 1
    }
}

private func splitByRail(_ text: String, lengths: [Int]) -> [ArraySlice<Character>] {
    let characters = Array(text)
    var start = 0

    return lengths.map { length in
        let slice = characters[start..<(start + length)]
        start += length

        return slice
    }
}

func encode(_ text: String, rails: Int) -> String {
    let indices = railIndices(length: text.count, rails: rails)
    var buckets = Array(repeating: "", count: rails)

    for (character, rail) in zip(text, indices) {
        buckets[rail].append(character)
    }

    return buckets.joined()
}

func decode(_ text: String, rails: Int) -> String {
    let indices = railIndices(length: text.count, rails: rails)
    let lengths = railLengths(from: indices, count: rails)

    let railSlices = splitByRail(text, lengths: lengths)

    var offsets = Array(repeating: 0, count: rails)

    return String(indices.map { rail in
        let slice = railSlices[rail]
        let character = slice[slice.startIndex + offsets[rail]]
        offsets[rail] += 1

        return character
    })
}