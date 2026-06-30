use core::dict::Felt252Dict;

pub fn units() -> Felt252Dict<u32> {
    let mut dict: Felt252Dict<u32> = Default::default();

    dict.insert('quarter_of_a_dozen', 3);
    dict.insert('half_of_a_dozen', 6);
    dict.insert('dozen', 12);
    dict.insert('small_gross', 120);
    dict.insert('gross', 144);
    dict.insert('great_gross', 1728);

    dict
}

pub fn new_bill() -> Felt252Dict<u32> {
    Default::default()
}

pub fn add_item(
    ref bill: Felt252Dict<u32>,
    ref units: Felt252Dict<u32>,
    item: felt252,
    unit: felt252,
) -> bool {
    let qty = units.get(unit);

    if qty == 0 {
        return false;
    }

    let current = bill.get(item);
    bill.insert(item, current + qty);

    true
}

pub fn remove_item(
    ref bill: Felt252Dict<u32>,
    ref units: Felt252Dict<u32>,
    item: felt252,
    unit: felt252,
) -> bool {
    let current = bill.get(item);
    if current == 0 {
        return false;
    }

    let qty = units.get(unit);
    if qty == 0 {
        return false;
    }

    if current < qty {
        return false;
    }

    bill.insert(item, current - qty);
    true
}

pub fn get_item(ref bill: Felt252Dict<u32>, item: felt252) -> u32 {
    bill.get(item)
}