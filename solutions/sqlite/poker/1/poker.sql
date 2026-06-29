update poker
set result = (
    with
    card_strings as (
        select key as num, value as hand
        from json_each(hands)
    ),
    cards(num,rank,suit) as (
        select num,
            case substr(value, 1, 1)
            when 'J' then 11
            when 'Q' then 12
            when 'K' then 13
            when 'A' then 14
            when '1' then 10
            else cast(substr(value, 1, 1) as integer)
            end,
            substr(value, -1)
        from card_strings, json_each('["' || replace(hand, ' ', '","') || '"]')
    ),
    cards_low_ace(num,rank,suit) as (
        select num, iif(rank=14, 1, rank), suit
        from cards
    ),
    card_counts as (
        select num, rank, count(*) as c
        from cards
        group by num, rank
    ),
    find_straight_flush as (
        select num, max(rank + 1 = l1 and l1 + 1 = l2 and l2 + 1 = l3 and l3 + 1 = l4) as res, l4 as tie1
        from (
            select num, rank,
             lead(rank) over (partition by num, suit order by rank) as l1,
             lead(rank, 2) over (partition by num, suit order by rank) as l2,
             lead(rank, 3) over (partition by num, suit order by rank) as l3,
             lead(rank, 4) over (partition by num, suit order by rank) as l4
            from cards
        )
        group by num
    ),
    find_straight_flush_low_ace as (
        select num, max(rank + 1 = l1 and l1 + 1 = l2 and l2 + 1 = l3 and l3 + 1 = l4) as res, l4 as tie1
        from (
            select num, rank,
             lead(rank) over (partition by num, suit order by rank) as l1,
             lead(rank, 2) over (partition by num, suit order by rank) as l2,
             lead(rank, 3) over (partition by num, suit order by rank) as l3,
             lead(rank, 4) over (partition by num, suit order by rank) as l4
            from cards_low_ace
        )
        group by num
    ),
    find_four_of_a_kind as (
        select num, max(c) = 4 as res,
          (select rank from card_counts cc where cc.num = card_counts.num and cc.c = 4) as tie1,
          (select rank from card_counts cc where cc.num = card_counts.num and cc.c = 1) as tie2
        from card_counts
        group by num
    ),
    find_full_house as (
        select num, max(c) = 3 and min(c) = 2 as res,
          (select rank from card_counts cc where cc.num = card_counts.num and cc.c = 3) as tie1,
          (select rank from card_counts cc where cc.num = card_counts.num and cc.c = 2) as tie2
        from card_counts
        group by num
    ),
    find_flush as (
        select num, max(c) = 5 as res,
            (select max(rank) from cards c where c.num = suit_counts.num) as tie1,
            (select rank from cards c where c.num = suit_counts.num order by rank desc limit 1 offset 1) as tie2,
            (select rank from cards c where c.num = suit_counts.num order by rank desc limit 1 offset 2) as tie3,
            (select rank from cards c where c.num = suit_counts.num order by rank desc limit 1 offset 3) as tie4,
            (select rank from cards c where c.num = suit_counts.num order by rank desc limit 1 offset 4) as tie5
        from (
            select num, count(*) as c
            from cards
            group by num, suit
        ) suit_counts
        group by num
    ),
    find_straight as (
        select num, max(rank + 1 = l1 and l1 + 1 = l2 and l2 + 1 = l3 and l3 + 1 = l4) as res, l4 as tie1
        from (
            select num, rank,
             lead(rank) over (partition by num order by rank) as l1,
             lead(rank, 2) over (partition by num order by rank) as l2,
             lead(rank, 3) over (partition by num order by rank) as l3,
             lead(rank, 4) over (partition by num order by rank) as l4
            from cards
        )
        group by num
    ),
    find_straight_low_ace as (
        select num, max(rank + 1 = l1 and l1 + 1 = l2 and l2 + 1 = l3 and l3 + 1 = l4) as res, l4 as tie1
        from (
            select num, rank,
             lead(rank) over (partition by num order by rank) as l1,
             lead(rank, 2) over (partition by num order by rank) as l2,
             lead(rank, 3) over (partition by num order by rank) as l3,
             lead(rank, 4) over (partition by num order by rank) as l4
            from cards_low_ace
        )
        group by num
    ),
    find_three_of_a_kind as (
        select num, max(c) = 3 and min(c) = 1 as res,
          (select rank from card_counts cc where cc.num = card_counts.num and cc.c = 3) as tie1,
          (select max(rank) from card_counts cc where cc.num = card_counts.num and cc.c = 1) as tie2,
          (select min(rank) from card_counts cc where cc.num = card_counts.num and cc.c = 1) as tie3
        from card_counts
        group by num
    ),
    find_two_pairs as (
        select num, (select c from card_counts cc where cc.num = card_counts.num order by c desc limit 1) = 2
            and (select c from card_counts cc where cc.num = card_counts.num order by c desc limit 1 offset 1) = 2 as res,
          (select max(rank) from card_counts cc where cc.num = card_counts.num and cc.c = 2) as tie1,
          (select min(rank) from card_counts cc where cc.num = card_counts.num and cc.c = 2) as tie2,
          (select rank from card_counts cc where cc.num = card_counts.num and cc.c = 1) as tie3
        from card_counts
        group by num
    ),
    find_one_pair as (
        select num, max(c) = 2 and min(c) = 1 as res,
          (select rank from card_counts cc where cc.num = card_counts.num and cc.c = 2) as tie1,
          (select max(rank) from card_counts cc where cc.num = card_counts.num and cc.c = 1) as tie2,
          (select rank from card_counts cc where cc.num = card_counts.num and cc.c = 1 order by rank desc limit 1 offset 1) as tie3,
          (select rank from card_counts cc where cc.num = card_counts.num and cc.c = 1 order by rank desc limit 1 offset 2) as tie4
        from card_counts
        group by num
    ),
    find_high_card as (
        select num, max(c) = 1 as res,
          (select max(rank) from cards cs where cs.num = card_counts.num) as tie1,
          (select rank from cards cs where cs.num = card_counts.num order by rank desc limit 1 offset 1) as tie2,
          (select rank from cards cs where cs.num = card_counts.num order by rank desc limit 1 offset 2) as tie3,
          (select rank from cards cs where cs.num = card_counts.num order by rank desc limit 1 offset 3) as tie4,
          (select rank from cards cs where cs.num = card_counts.num order by rank desc limit 1 offset 4) as tie5
        from card_counts
        group by num
    ),
    scores as (
        select num, hand, case
            when 1 = (select res from find_straight_flush where num = cs.num)
                then (select format('9,%02d', tie1) from find_straight_flush where num = cs.num)
            when 1 = (select res from find_straight_flush_low_ace where num = cs.num)
                then (select format('9,%02d', tie1) from find_straight_flush_low_ace where num = cs.num)
            when 1 = (select res from find_four_of_a_kind where num = cs.num)
                then (select format('8,%02d,%02d', tie1, tie2) from find_four_of_a_kind where num = cs.num)
            when 1 = (select res from find_full_house where num = cs.num)
                then (select format('7,%02d,%02d', tie1, tie2) from find_full_house where num = cs.num)
            when 1 = (select res from find_flush where num = cs.num)
                then (select format('6,%02d,%02d,%02d,%02d,%02d', tie1, tie2, tie3, tie4, tie5) from find_flush where num = cs.num)
            when 1 = (select res from find_straight where num = cs.num)
                then (select format('5,%02d', tie1) from find_straight where num = cs.num)
            when 1 = (select res from find_straight_low_ace where num = cs.num)
                then (select format('5,%02d', tie1) from find_straight_low_ace where num = cs.num)
            when 1 = (select res from find_three_of_a_kind where num = cs.num)
                then (select format('4,%02d,%02d,%02d', tie1, tie2, tie3) from find_three_of_a_kind where num = cs.num)
            when 1 = (select res from find_two_pairs where num = cs.num)
                then (select format('3,%02d,%02d,%02d', tie1, tie2, tie3) from find_two_pairs where num = cs.num)
            when 1 = (select res from find_one_pair where num = cs.num)
                then (select format('2,%02d,%02d,%02d,%02d', tie1, tie2, tie3, tie4) from find_one_pair where num = cs.num)
            when 1 = (select res from find_high_card where num = cs.num)
                then (select format('1,%02d,%02d,%02d,%02d,%02d', tie1, tie2, tie3, tie4, tie5) from find_high_card where num = cs.num)
            end as s
        from card_strings cs
    )
    select json_group_array(hand)
    from scores
    where s = (select max(s) from scores)
);
