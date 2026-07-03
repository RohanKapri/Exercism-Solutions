struct ListOps {
    static func append<T>(_ list1: [T], _ list2: [T]) -> [T] {
        list1 + list2
    }
    
    static func concat<T>(_ lists: [[T]]) -> [T] {
        var result = [T]()
        for list in lists {
            result += list
        }

        return result
    }
    
    static func filter<T>(_ list: [T], _ function: (T) -> Bool) -> [T] {
        var result = [T]()
        for element in list {
            if function(element) { result.append(element) }
        }

        return result
    }
    
    static func length<T>(_ list: [T]) -> Int {
        list.count
    }
    
    static func map<T, U>(_ list: [T], _ function: (T) -> U) -> [U] {
        var result = [U]()
        for element in list {
            result.append(function(element))
        }
        return result
    }
    
    static func foldLeft<T>(_ list: [T], accumulated: T, combine: (T, T) -> T) -> T {
        var result = accumulated
        for element in list {
            result = combine(element, result)
        }

        return result
    }
    
    static func foldRight<T>(_ list: [T], accumulated: T, combine: (T, T) -> T) -> T {
        foldLeft(reverse(list), accumulated: accumulated, combine: combine)
    }
    
    static func reverse<T>(_ list: [T]) -> [T] {
        var result = [T]()
        
        for index in stride(from: list.count - 1, through: 0, by: -1) {
            result.append(list[index])
        }
        
        return result
    }
}