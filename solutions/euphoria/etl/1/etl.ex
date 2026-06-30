include std/map.e
include std/text.e

public function transform(map legacy)
    map:map result = map:new()
    sequence pairs = map:pairs(legacy)
    
    for i = 1 to length(pairs) do
        integer score = pairs[i][1]
        sequence letters = pairs[i][2]
        
        for j = 1 to length(letters) do
            map:put(result, lower(letters[j]), score)
        end for
    end for
    
    return result
end function