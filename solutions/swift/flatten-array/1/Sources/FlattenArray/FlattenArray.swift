func flattenArray<T>(_ list: [Any?]) -> [T] {
    list.reduce(into: [T]()) { result, element in
        switch element {
        case let sublist as [Any?]: result += flattenArray(sublist)
        case let value as T:        result.append(value)
        default:                    break
        }
    }
}