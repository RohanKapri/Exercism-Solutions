include std/math.e
include std/rand.e

public function modifier(integer score)
    return floor((score - 10) / 2)
end function

public function sort(sequence rolls)
    for i = 1 to length(rolls) do
        for j = i + 1 to length(rolls) do
            if rolls[i] > rolls[j] then
                integer temp = rolls[i]
                rolls[i] = rolls[j]
                rolls[j] = temp
            end if
        end for
    end for
    return rolls
end function


public function ability()
    sequence rolls = {}
    for i = 1 to 4 do
        rolls = append(rolls, rand(5) + 1)
    end for
    rolls = sort(rolls)
    return sum(rolls[2..4])
end function

public function new_character()
    return {
        ability(),  -- Strength
        ability(),  -- Dexterity
        ability(),  -- Constitution
        ability(),  -- Intelligence
        ability(),  -- Wisdom
        ability()   -- Charisma
    }
end function

public function get_strength(sequence character)
    return character[1]
end function

public function get_dexterity(sequence character)
    return character[2]
end function

public function get_constitution(sequence character)
    return character[3]
end function

public function get_intelligence(sequence character)
    return character[4]
end function

public function get_wisdom(sequence character)
    return character[5]
end function

public function get_charisma(sequence character)
    return character[6]
end function

public function get_hitpoints(sequence character)
    return 10 + modifier(get_constitution(character))
end function