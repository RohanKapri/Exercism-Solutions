function additems!(cart, items)
    foreach(item -> mergewith!(+, cart, Dict(item => 1)), items)
    cart
end

update_recipes! = merge!

function send_to_store(cart, aislecodes)
    [aislecodes[item] => cart[item] for item in keys(cart)] |> sort!
end

function update_store_inventory!(inventory, cart)
    mergewith!(-, inventory, cart)
    filter(item -> item.second == 0, inventory)
end

function reorder!(outofstock, stock)
    foreach(item -> outofstock[item] = get!(stock, item, 100), keys(outofstock))
    outofstock
end