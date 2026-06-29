clothingitem(categories, qualities) = 
    Dict(cat => qual for (cat, qual) in zip(categories, qualities))

get_combinations(tops, bottoms) = [(top, bottom) for top in tops, bottom in bottoms]

get_prices(combos) = [top["price"] + bottom["price"] for (top, bottom) in combos]

filter_clashing(combos) =
    [(top, bottom) for (top, bottom) in combos if top["base_color"] ≠ bottom["base_color"]]