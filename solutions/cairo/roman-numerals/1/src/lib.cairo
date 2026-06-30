use core::fmt::{Display, Error, Formatter};

#[derive(Drop)]
pub struct Roman {
    value: u32,
}

impl U32IntoRoman of Into<u32, Roman> {
    #[must_use]
    fn into(self: u32) -> Roman {
        Roman { value: self }
    }
}


impl RomanDisplay of Display<Roman> {
    fn fmt(self: @Roman, ref f: Formatter) -> Result<(), Error> {
        // Define the roman numeral values and their corresponding symbols
        // Including the special subtraction cases (4, 9, 40, 90, 400, 900)
        let values: Array<u32> = array![1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1];
        let symbols: Array<ByteArray> = array![
            "M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"
        ];

        let mut result: ByteArray = "";
        let mut remaining = *self.value;
        let mut i = 0;

        // Process each value from largest to smallest
        while i < values.len() {
            let current_value = *values.at(i);
            let current_symbol = symbols.at(i);
            
            // Add the symbol as many times as the value fits into remaining
            while remaining >= current_value {
                result.append(current_symbol);
                remaining = remaining - current_value;
            };
            
            i += 1;
        };

        write!(f, "{}", result)
    }
}