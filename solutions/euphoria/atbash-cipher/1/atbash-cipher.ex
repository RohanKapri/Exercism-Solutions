include std/text.e

-- Helper function to convert a character using Atbash cipher
function convert_char(integer c)
    if c >= 'a' and c <= 'z' then
        return 'a' + ('z' - c)
    elsif c >= 'A' and c <= 'Z' then
        return 'a' + ('z' - lower(c))
    elsif c >= '0' and c <= '9' then
        return c
    end if
    
    return -1
end function

-- Helper function to clean and convert text
function clean_and_convert(sequence phrase)
    sequence result = ""
    
    for i = 1 to length(phrase) do
        integer converted = convert_char(phrase[i])
        if converted != -1 then
            result &= converted
        end if
    end for
    
    return result
end function

public function encode(sequence phrase)
    sequence cleaned = clean_and_convert(phrase)
    sequence result = ""
    
    for i = 1 to length(cleaned) do
        if remainder(i-1, 5) = 0 and i != 1 then
            result &= " "
        end if
        result &= cleaned[i]
    end for
    
    return result
end function

public function decode(sequence phrase)
    -- For decoding, we just need to clean and convert, 
    -- as the cipher is its own inverse
    return clean_and_convert(phrase)
end function