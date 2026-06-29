local ENGLISH, JAPANESE, NORWEGIAN, SPANISH, UKRAINIAN = 0, 1, 2, 3, 4
local BLUE, GREEN, IVORY, RED, YELLOW = 0, 1, 2, 3, 4
local DOG, FOX, HORSE, SNAILS, ZEBRA = 0, 1, 2, 3, 4
local COFFEE, MILK, ORANGE_JUICE, TEA, WATER = 0, 1, 2, 3, 4
local CHESTERFIELD, KOOL, LUCKY_STRIKE, OLD_GOLD, PARLIAMENT = 0, 1, 2, 3, 4

local function permutations(list)
  if #list == 1 then
    return { { list[1] } }
  end
  local results = {}
  for i = 1, #list do
    local rest = {}
    for j = 1, #list do
      if i ~= j then
        table.insert(rest, list[j])
      end
    end
    for _, perm in ipairs(permutations(rest)) do
      table.insert(results, { list[i], table.unpack(perm) })
    end
  end
  return results
end

local function nationality_string(nationality)
  return ({ 'English', 'Japanese', 'Norwegian', 'Spanish', 'Ukrainian' })[nationality + 1]
end

local function is_valid_color(color)
  return color[GREEN + 1] - 1 == color[IVORY + 1]
end

local function is_valid_nationality(nationality, color)
  return nationality[NORWEGIAN + 1] == 0 and
    nationality[ENGLISH + 1] == color[RED + 1] and
    math.abs(nationality[NORWEGIAN + 1] - color[BLUE + 1]) == 1
end

local function is_valid_pet(nationality, pet)
  return nationality[SPANISH + 1] == pet[DOG + 1]
end

local function is_valid_beverage(beverage, color, nationality)
  return beverage[COFFEE + 1] == color[GREEN + 1] and
    nationality[UKRAINIAN + 1] == beverage[TEA + 1] and
    beverage[MILK + 1] == 2
end

local function is_valid_brand(brand, pet, beverage, nationality, color)
  return brand[OLD_GOLD + 1] == pet[SNAILS + 1] and
    brand[KOOL + 1] == color[YELLOW + 1] and
    math.abs(brand[CHESTERFIELD + 1] - pet[FOX + 1]) == 1 and
    math.abs(brand[KOOL + 1] - pet[HORSE + 1]) == 1 and
    brand[LUCKY_STRIKE + 1] == beverage[ORANGE_JUICE + 1] and
    nationality[JAPANESE + 1] == brand[PARLIAMENT + 1]
end

local function solve()
  local houses = { 0, 1, 2, 3, 4 }

  for _, color in ipairs(permutations(houses)) do
    if is_valid_color(color) then
      for _, nationality in ipairs(permutations(houses)) do
        if is_valid_nationality(nationality, color) then
          for _, pet in ipairs(permutations(houses)) do
            if is_valid_pet(nationality, pet) then
              for _, beverage in ipairs(permutations(houses)) do
                if is_valid_beverage(beverage, color, nationality) then
                  for _, brand in ipairs(permutations(houses)) do
                    if is_valid_brand(brand, pet, beverage, nationality, color) then
                      return {
                        drinks_water = nationality_string(nationality[beverage[WATER + 1] + 1]),
                        owns_zebra = nationality_string(nationality[pet[ZEBRA + 1] + 1])
                      }
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  return { drinks_water = nil, owns_zebra = nil }
end

local solution = solve()

return {
  drinks_water = function() return solution.drinks_water end,
  owns_zebra = function() return solution.owns_zebra end
}