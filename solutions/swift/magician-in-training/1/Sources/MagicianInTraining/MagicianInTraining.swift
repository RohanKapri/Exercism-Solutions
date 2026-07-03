func getCard(at index: Int, from stack: [Int]) -> Int {
  guard stack.indices.contains(index) else { return -1 }
  return stack[index]
}

func setCard(at index: Int, in stack: [Int], to newCard: Int) -> [Int] {
  guard stack.indices.contains(index) else { return stack }
  var ret: [Int] = stack
  ret[index] = newCard
  return ret
}

func insert(_ newCard: Int, atTopOf stack: [Int]) -> [Int] {
  return stack + [newCard]
}

func removeCard(at index: Int, from stack: [Int]) -> [Int] {
  guard stack.indices.contains(index) else { return stack }
  var ret: [Int] = stack
  ret.remove(at: index)
  return ret
}

func insert(_ newCard: Int, at index: Int, from stack: [Int]) -> [Int] {
  guard index >= 0, index <= stack.endIndex else { return stack }
  var ret: [Int] = stack
  ret.insert(newCard, at: index)
  return ret
}

func checkSizeOfStack(_ stack: [Int], _ size: Int) -> Bool {
  return stack.count == size
}