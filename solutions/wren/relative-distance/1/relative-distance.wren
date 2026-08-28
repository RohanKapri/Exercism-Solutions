class RelativeDistance {
  construct new(familyTree) {
    _connections = {}
    for (parent in familyTree.keys) {
      var children = familyTree[parent]
      for (i in 0...children.count) {
        connect(parent, children[i])
        for (j in (i+1)...children.count) {
          connect(children[i], children[j])
        }
      }
    }
  }

  connect(personA, personB) {
    if (!_connections.containsKey(personA)) {
      _connections[personA] = {}
    }
    if (!_connections.containsKey(personB)) {
      _connections[personB] = {}
    }
    _connections[personA][personB] = true
    _connections[personB][personA] = true
  }

  degreeOfSeparation(personA, personB) {
    if (personB == personA) {
      return 0
    }

    var seen = { personA : true }
    var current = []
    var next = [personA]
    var distance = 0
    while (next.count > 0) {
      current = next
      next = []
      distance = distance + 1
      for (person in current) {
        for (connection in _connections[person].keys) {
          if (seen.containsKey(connection)) {
            continue
          }
          if (connection == personB) {
            return distance
          }
          seen[connection] = true
          next.add(connection)
        }
      }
    }

    return null
  }
}