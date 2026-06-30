use core::traits::{Add, PartialOrd, Sub};

// Define the TimeShard struct
#[derive(Drop, Debug, PartialEq)]
pub struct TimeShard {
    pub value: i32,
}

// Implement addition
impl TimeShardAdd of Add<TimeShard> {
    fn add(lhs: TimeShard, rhs: TimeShard) -> TimeShard {
        TimeShard {
            value: lhs.value + rhs.value,
        }
    }
}

// Implement subtraction
impl TimeShardSub of Sub<TimeShard> {
    fn sub(lhs: TimeShard, rhs: TimeShard) -> TimeShard {
        TimeShard {
            value: lhs.value - rhs.value,
        }
    }
}

// Implement comparison
impl TimeShardPartialOrd of PartialOrd<TimeShard> {
    fn lt(lhs: TimeShard, rhs: TimeShard) -> bool {
        lhs.value < rhs.value
    }

    fn le(lhs: TimeShard, rhs: TimeShard) -> bool {
        lhs.value <= rhs.value
    }

    fn gt(lhs: TimeShard, rhs: TimeShard) -> bool {
        lhs.value > rhs.value
    }

    fn ge(lhs: TimeShard, rhs: TimeShard) -> bool {
        lhs.value >= rhs.value
    }
}