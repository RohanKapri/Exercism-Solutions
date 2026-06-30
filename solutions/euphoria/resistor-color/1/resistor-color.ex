sequence RESISTOR_COLORS = {"black", "brown", "red", "orange", "yellow", "green", "blue", "violet", "grey", "white"}

public function colorCode(sequence color)
    return find(color, RESISTOR_COLORS) - 1  -- Subtract 1 because Euphoria is 1-indexed
end function
  
public function colors()
    return RESISTOR_COLORS
end function