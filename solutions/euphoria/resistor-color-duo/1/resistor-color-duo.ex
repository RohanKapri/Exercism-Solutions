sequence RESISTOR_COLORS = {"black", "brown", "red", "orange", "yellow", "green", "blue", "violet", "grey", "white"}

public function value(sequence colors)
    return (find(colors[1], RESISTOR_COLORS) - 1) * 10 + (find(colors[2], RESISTOR_COLORS) - 1)
end function