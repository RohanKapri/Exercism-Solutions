public type Node record {
    int value;
    Node? next;
    Node? prev;
};

public type LinkedList record {
    Node? head;
    Node? tail;
};

public function newLinkedList() returns LinkedList {
    return {head: (), tail: ()};
}

public function count(LinkedList list) returns int {
    int count = 0;
    Node? currentNode = list.head;
    while (currentNode is Node) {
        count += 1;
        currentNode = currentNode.next;
    }
    return count;
}

public function push(LinkedList list, int value) {
    Node newNode = {value: value, next: (), prev: list.tail};
    if (list.tail is Node) {
        Node tailNode = <Node> list.tail;
        tailNode.next = newNode;
    }
    list.tail = newNode;
    if (list.head is ()) {
        list.head = newNode;
    }
}

public function unshift(LinkedList list, int value) {
    Node newNode = {value: value, next: list.head, prev: ()};
    if (list.head is Node) {
        Node headNode = <Node> list.head;
        headNode.prev = newNode;
    }
    list.head = newNode;
    if (list.tail is ()) {
        list.tail = newNode;
    }
}

public function pop(LinkedList list) returns int? {
    if (list.tail is Node) {
        Node tailNode = <Node> list.tail;
        int value = tailNode.value;
        list.tail = tailNode.prev;
        if (list.tail is Node) {
            Node newTailNode = <Node> list.tail;
            newTailNode.next = ();
        } else {
            list.head = ();
        }
        return value;
    }
    return ();
}

public function shift(LinkedList list) returns int? {
    if (list.head is Node) {
        Node headNode = <Node> list.head;
        int value = headNode.value;
        list.head = headNode.next;
        if (list.head is Node) {
            Node newHeadNode = <Node> list.head;
            newHeadNode.prev = ();
        } else {
            list.tail = ();
        }
        return value;
    }
    return ();
}

public function delete(LinkedList list, int value) {
    Node? currentNode = list.head;
    while (currentNode is Node) {
        Node currentNodeValue = <Node> currentNode;
        if (currentNodeValue.value == value) {
            if (currentNodeValue.prev is Node) {
                Node prevNode = <Node> currentNodeValue.prev;
                prevNode.next = currentNodeValue.next;
            } else {
                list.head = currentNodeValue.next;
            }
            if (currentNodeValue.next is Node) {
                Node nextNode = <Node> currentNodeValue.next;
                nextNode.prev = currentNodeValue.prev;
            } else {
                list.tail = currentNodeValue.prev;
            }
            break;
        }
        currentNode = currentNodeValue.next;
    }
}