-- This exercise really needs better instructions!
-- (Timus's solution showed the intention of the exercise.)

with random_attributes as (
    select (
        with dice_throws as (
            select abs(random()) % 6 + 1 as t
            from generate_series(1,4)  
        )
        select sum(t) - min(t)
        from dice_throws
    ) as attr
    from generate_series(1,6)
),
attr_seq as (
    select group_concat(format('%02d', attr), '') as a
    from random_attributes
)
update "dnd-character"
set strength = substr(a,1,2),
    dexterity = substr(a,3,2),
    constitution = ifnull(constitution, substr(a,5,2)),
    intelligence = substr(a,7,2),
    wisdom = substr(a,9,2),
    charisma = substr(a,11,2),
    modifier = floor((ifnull(constitution, substr(a,5,2)) - 10) / 2.0),
    hitpoints = 10 + floor((ifnull(constitution, substr(a,5,2)) - 10) / 2.0)
from attr_seq;