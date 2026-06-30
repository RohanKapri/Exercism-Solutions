/// Types of pastries available in the bakery
#[derive(Drop, PartialEq)]
pub enum Pastry {
    Croissant,
    Muffin,
    Cookie,
}

/// Calculate the total cost of an order
pub fn calculate_total(pastry: Pastry, quantity: u32) -> u32 {
    let price = match pastry {
        Pastry::Croissant => 3,
        Pastry::Muffin => 2,
        Pastry::Cookie => 1,
    };

    price * quantity
}

/// Apply discount based on order size
pub fn apply_discount(total: u32) -> u32 {
    if total >= 20 {
        total * 90 / 100
    } else if total >= 10 {
        total * 95 / 100
    } else {
        total
    }
}

/// Generate the daily baking schedule
pub fn baking_schedule(total_orders: u32) -> Array<u32> {
    let mut schedule = ArrayTrait::new();
    let mut remaining = total_orders;

    loop {
        if remaining == 0 {
            break;
        }

        if remaining >= 5 {
            schedule.append(5);
            remaining -= 5;
        } else {
            schedule.append(remaining);
            break;
        }
    };

    schedule
}