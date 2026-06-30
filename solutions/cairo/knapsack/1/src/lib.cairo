use core::dict::Felt252Dict;

#[derive(Drop)]
pub struct Item {
    pub weight: u32,
    pub value: u32,
}

pub fn maximum_value(maximum_weight: u32, items: Span<Item>) -> u32 {
    if items.len() == 0 || maximum_weight == 0 {
        return 0;
    }
    
    // Use dictionary for DP table
    let mut dp: Felt252Dict<u32> = Default::default();
    
    // Process each item
    let mut item_idx = 0;
    loop {
        if item_idx >= items.len() {
            break;
        }
        
        let item = items.at(item_idx);
        
        // Process weights in reverse order to avoid using an item multiple times
        let mut w = maximum_weight;
        loop {
            if w < *item.weight {
                break;
            }
            
            let weight_key: felt252 = w.into();
            let prev_weight_key: felt252 = (w - *item.weight).into();
            
            let current_value = dp.get(weight_key);
            let value_with_item = dp.get(prev_weight_key) + *item.value;
            
            if value_with_item > current_value {
                dp.insert(weight_key, value_with_item);
            }
            
            if w == *item.weight {
                break;
            }
            w -= 1;
        };
        
        item_idx += 1;
    };
    
    dp.get(maximum_weight.into())
}
    