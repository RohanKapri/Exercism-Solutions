
class LinkedList:
    class ListNode:
        var value: int
        var prev = null
        var next = null

        func _init(v: int):
            value = v

    var head = null
    var tail = null
    var size = 0

    func push(value: int):
        var node = ListNode.new(value)

        if tail == null:
            head = node
            tail = node
        else:
            node.prev = tail
            tail.next = node
            tail = node

        size += 1

    func unshift(value: int):
        var node = ListNode.new(value)

        if head == null:
            head = node
            tail = node
        else:
            node.next = head
            head.prev = node
            head = node

        size += 1

    func pop():
        if tail == null:
            return null

        var value = tail.value
        tail = tail.prev

        if tail == null:
            head = null
        else:
            tail.next = null

        size -= 1
        return value

    func shift():
        if head == null:
            return null

        var value = head.value
        head = head.next

        if head == null:
            tail = null
        else:
            head.prev = null

        size -= 1
        return value

    func delete(value: int):
        var current = head

        while current != null:
            if current.value == value:
                if current.prev != null:
                    current.prev.next = current.next
                else:
                    head = current.next

                if current.next != null:
                    current.next.prev = current.prev
                else:
                    tail = current.prev

                size -= 1
                return

            current = current.next

    func count() -> int:
        return size
