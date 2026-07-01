{
  combinations: (input) ->
    target = input.sum
    size = input.size
    excluded = {}

    for n in *input.exclude
      excluded[n] = true

    result = {}
    

    search = (start, remain, count, current) ->
      if count == size
        if remain == 0
          table.insert result, table.concat current
        return

      for digit = start, 9
        continue if excluded[digit]
        continue if digit > remain

        current[#current + 1] = tostring digit
        search digit + 1, remain - digit, count + 1, current
        current[#current] = nil

    search 1, target, 0, {}

    table.sort result
    result
}