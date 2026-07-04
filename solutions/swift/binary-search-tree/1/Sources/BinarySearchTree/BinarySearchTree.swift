class BinarySearchTree<Element: Comparable> {
    var data: Element
    var left: BinarySearchTree<Element>?
    var right: BinarySearchTree<Element>?

    init(_ value: Element) {
        data = value
    }

    func insert(_ value: Element) {
        if data >= value {
            left?.insert(value) ?? (left = BinarySearchTree(value))
        } else {
            right?.insert(value) ?? (right = BinarySearchTree(value))
        }
    }

    func allData() -> [Element] {
        let leftData = left?.allData() ?? []
        let rightData = right?.allData() ?? []

        return leftData + [data] + rightData
    }
}