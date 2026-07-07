#[derive(Drop)]
pub struct Player {
    pub health: u32,
    pub mana: Option<u32>,
    pub level: u32,
}

#[generate_trait]
pub impl PlayerImpl of PlayerTrait {
    fn revive(self: @Player) -> Option<Player> {
        if *self.health != 0 {
            Option::None
        } else {
            Option::Some(
                Player {
                    health: 100,
                    mana: if *self.level >= 10 {
                        Option::Some(100)
                    } else {
                        Option::None
                    },
                    level: *self.level,
                }
            )
        }
    }

    fn cast_spell(ref self: Player, mana_cost: u32) -> u32 {
        match self.mana {
            Option::None => {
                self.health = if self.health >= mana_cost {
                    self.health - mana_cost
                } else {
                    0
                };
                0
            },
            Option::Some(mana) => {
                if mana < mana_cost {
                    0
                } else {
                    self.mana = Option::Some(mana - mana_cost);
                    mana_cost * 2
                }
            },
        }
    }
}