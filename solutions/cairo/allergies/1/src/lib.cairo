#[derive(Drop)]
pub struct Allergies {
    score: u32,
}

#[derive(Drop, Debug, PartialEq, Copy)]
pub enum Allergen {
    Eggs,
    Peanuts,
    Shellfish,
    Strawberries,
    Tomatoes,
    Chocolate,
    Pollen,
    Cats,
}

#[generate_trait]
pub impl AllergiesImpl of AllergiesTrait {
    fn new(score: u32) -> Allergies {
        // Mask the score to only consider the valid allergen bits (0-255)
        // This handles the case where scores > 255 should ignore higher bits
        Allergies { score: score & 255 }
    }

    fn is_allergic_to(self: @Allergies, allergen: @Allergen) -> bool {
        let allergen_value = get_allergen_value(allergen);
        (*self.score & allergen_value) == allergen_value
    }

    fn allergies(self: @Allergies) -> Array<Allergen> {
        let mut result = array![];
        let all_allergens = array![
            Allergen::Eggs,
            Allergen::Peanuts,
            Allergen::Shellfish,
            Allergen::Strawberries,
            Allergen::Tomatoes,
            Allergen::Chocolate,
            Allergen::Pollen,
            Allergen::Cats,
        ];
        
        let mut i = 0;
        while i < all_allergens.len() {
            let allergen = all_allergens.at(i);
            if self.is_allergic_to(allergen) {
                result.append(*allergen);
            }
            i += 1;
        };
        
        result
    }
}

fn get_allergen_value(allergen: @Allergen) -> u32 {
    match allergen {
        Allergen::Eggs => 1,
        Allergen::Peanuts => 2,
        Allergen::Shellfish => 4,
        Allergen::Strawberries => 8,
        Allergen::Tomatoes => 16,
        Allergen::Chocolate => 32,
        Allergen::Pollen => 64,
        Allergen::Cats => 128,
    }
}