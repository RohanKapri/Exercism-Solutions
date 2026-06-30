include wildcard.e

public function is_pangram(sequence sentence)
    sequence alphabet = "abcdefghijklmnopqrstuvwxyz"
    sentence = lower(sentence)
    
    for i = 1 to length(alphabet) do
        if not find(alphabet[i], sentence) then
            return 0
        end if
    end for
    
    return 1
end function