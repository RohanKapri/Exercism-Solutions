use core::fmt::{Display, Formatter, Error};

#[derive(Drop, PartialEq, Debug)]
pub struct Clock {
    minutes: u32,
}

impl ClockDisplay of Display<Clock> {
    fn fmt(self: @Clock, ref f: Formatter) -> Result<(), Error> {
        let hours = *self.minutes / 60;
        let minutes = *self.minutes % 60;
        
        // Format hours
        if hours < 10 {
            write!(f, "0{}", hours)?;
        } else {
            write!(f, "{}", hours)?;
        }
        
        write!(f, ":")?;
        
        // Format minutes
        if minutes < 10 {
            write!(f, "0{}", minutes)?;
        } else {
            write!(f, "{}", minutes)?;
        }
        
        Result::Ok(())
    }
}

#[generate_trait]
pub impl ClockImpl of ClockTrait {
    fn new(hour: i32, minute: i32) -> Clock {
        // Convert everything to total minutes and normalize to 0-1439 range (24 * 60 - 1)
        let total_minutes = hour * 60 + minute;
        
        // Handle negative values by adding days until positive
        let normalized_minutes = if total_minutes >= 0 {
            (total_minutes % 1440).try_into().unwrap()
        } else {
            // For negative values, we need to find the positive equivalent
            let mut normalized = total_minutes % 1440;
            if normalized < 0 {
                normalized += 1440;
            }
            normalized.try_into().unwrap()
        };
        
        Clock { minutes: normalized_minutes }
    }

    fn add_minutes(ref self: Clock, minutes: i32) -> Clock {
        // Convert current minutes to i32 for calculation
        let current_total = self.minutes.try_into().unwrap();
        let new_total = current_total + minutes;
        
        // Normalize to 0-1439 range
        let normalized_minutes = if new_total >= 0 {
            (new_total % 1440).try_into().unwrap()
        } else {
            let mut normalized = new_total % 1440;
            if normalized < 0 {
                normalized += 1440;
            }
            normalized.try_into().unwrap()
        };
        
        Clock { minutes: normalized_minutes }
    }

    fn to_string(self: @Clock) -> ByteArray {
        format!("{}", self)
    }
}
  