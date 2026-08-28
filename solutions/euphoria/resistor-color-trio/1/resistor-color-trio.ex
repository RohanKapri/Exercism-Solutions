function color_value(sequence color)
    if equal(color, "black") then
        return 0
    elsif equal(color, "brown") then
        return 1
    elsif equal(color, "red") then
        return 2
    elsif equal(color, "orange") then
        return 3
    elsif equal(color, "yellow") then
        return 4
    elsif equal(color, "green") then
        return 5
    elsif equal(color, "blue") then
        return 6
    elsif equal(color, "violet") then
        return 7
    elsif equal(color, "grey") then
        return 8
    else
        return 9 -- white
    end if
end function

public function value(sequence colors)
    atom resistance

    resistance =
        (color_value(colors[1]) * 10 +
         color_value(colors[2])) *
        power(10, color_value(colors[3]))

    if resistance = 0 then
        return "0 ohms"
    elsif remainder(resistance, 1000000000) = 0 then
        return sprintf("%d gigaohms",
                       {floor(resistance / 1000000000)})
    elsif remainder(resistance, 1000000) = 0 then
        return sprintf("%d megaohms",
                       {floor(resistance / 1000000)})
    elsif remainder(resistance, 1000) = 0 then
        return sprintf("%d kiloohms",
                       {floor(resistance / 1000)})
    else
        return sprintf("%d ohms", {resistance})
    end if
end function