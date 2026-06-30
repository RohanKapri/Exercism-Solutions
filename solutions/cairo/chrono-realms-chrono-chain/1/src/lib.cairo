use core::box::BoxTrait;

#[derive(Copy, Drop)]
pub enum ChronoChain {
    End,
    Link: (u32, Box<ChronoChain>),
}


#[generate_trait]
pub impl ChronoChainImpl of ChronoChainTrait {
    fn build(mut arr: Array<u32>) -> ChronoChain {
        match arr.pop_front() {
            Option::Some(value) => {
                ChronoChain::Link((
                    value,
                    BoxTrait::new(Self::build(arr)),
                ))
            },
            Option::None => ChronoChain::End,
        }
    }

    fn sum(self: ChronoChain) -> u64 {
        match self {
            ChronoChain::End => 0,
            ChronoChain::Link((value, next)) => {
                value.try_into().unwrap() + Self::sum(*next)
            },
        }
    }
}
