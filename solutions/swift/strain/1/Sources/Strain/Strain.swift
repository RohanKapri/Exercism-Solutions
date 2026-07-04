extension Array {
    func keep(_ f: (Element) -> Bool) -> [Element] {
        return result(f)
    }

    func discard(_ f: (Element) -> Bool) -> [Element] {
        return result { (Element) -> Bool in !f(Element) }
    }

    private func result(_ f: (Element) -> Bool) -> [Element] {
        var result = [Element]()
        for e in self {
            if f(e) {
                result.append(e)
            }
        }

        return result
    }
}