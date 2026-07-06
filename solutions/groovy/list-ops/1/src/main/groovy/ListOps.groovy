class ListOps {

    static append(list1, list2) {
        list2.each { element ->
            list1.add(element)
        }
        return list1
    }

    static concatenate(lists) {
        def result = []
        lists.each { list ->
            list.each { element ->
                result.add(element)
            }
        }
        return result
    }

    static filter(list, fn) {
        def result = []
        list.each { element ->
            if (fn(element)) {
                result.add(element)
            }
        }
        return result
    }

    static length(list) {
        def count = 0
        list.each { _ ->
            count++
        }
        return count
    }

    static map(list, fn) {
        def result = []
        list.each { element ->
            result.add(fn(element))
        }
        return result
    }

    static foldl(list, fn, initial) {
        def accumulator = initial
        list.each { element ->
            accumulator = fn(accumulator, element)
        }
        return accumulator
    }

    static foldr(list, fn, initial) {
        def accumulator = initial
        list.reverse().each { element ->
            accumulator = fn(accumulator, element)
        }
        return accumulator
    }

    static reverse(list) {
        def result = []
        for (int i = list.size() - 1; i >= 0; i--) {
            result.add(list[i])
        }
        return result
    }
}