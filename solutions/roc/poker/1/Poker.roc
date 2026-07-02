module [best_hands]

CardRank : U8
CardSuit : U8
Card : (CardRank, CardSuit)

## A hand is its original string paired with a packed U64 score.
Hand : (Str, U64)

best_hands : List Str -> Result (List Str) [NoValidHands]
best_hands = |hands_raw|
    when List.map_try(hands_raw, parse_hand) is
        Ok(hands) ->
            max_score = List.walk(hands, 0, |best, (_, s)| if s > best then s else best)
            winners = List.keep_if(hands, |(_, s)| s == max_score)
            Ok(List.map(winners, |(str, _)| str))

        Err _ ->
            Err(NoValidHands)

parse_hand : Str -> Result Hand [InvalidHand]
parse_hand = |hand_str|
    when Str.split_on(hand_str, " ") |> List.map_try(parse_card) is
        Ok(cards) ->
            when cards is
                [(r0, s0), (r1, s1), (r2, s2), (r3, s3), (r4, s4)] ->
                    sorted = List.sort_desc([r0, r1, r2, r3, r4])
                    when sorted is
                        [h0, h1, h2, h3, h4] ->
                            # All suits equal?
                            is_f = s0 == s1 && s1 == s2 && s2 == s3 && s3 == s4

                            # 4-bit equality signature from adjacent rank pairs
                            sig : U8
                            sig =
                                (if h0 == h1 then 8 else 0)
                                + (if h1 == h2 then 4 else 0)
                                + (if h2 == h3 then 2 else 0)
                                + (if h3 == h4 then 1 else 0)

                            score =
                                when sig is
                                    0 ->
                                        # All distinct: straight / flush / high-card branches
                                        # Sorted desc, so h0-h4 safe (h0>=h4 guaranteed).
                                        is_seq = h0 - h4 == 4
                                        is_al = h0 == 14 && h1 == 5 && h2 == 4 && h3 == 3 && h4 == 2
                                        if is_f && (is_seq || is_al) then
                                            pack(8, (if is_al then 5 else h0), 0, 0, 0, 0)
                                        else if is_f then
                                            pack(5, h0, h1, h2, h3, h4)
                                        else if is_seq then
                                            pack(4, h0, 0, 0, 0, 0)
                                        else if is_al then
                                            pack(4, 5, 0, 0, 0, 0)
                                        else
                                            pack(0, h0, h1, h2, h3, h4)

                                    # One-pair cases (pair rank first, then kickers desc)
                                    8  -> pack(1, h0, h2, h3, h4, 0)  # pair h0h1
                                    4  -> pack(1, h1, h0, h3, h4, 0)  # pair h1h2
                                    2  -> pack(1, h2, h0, h1, h4, 0)  # pair h2h3
                                    1  -> pack(1, h3, h0, h1, h2, 0)  # pair h3h4

                                    # Two-pair cases (hi-pair, lo-pair, kicker)
                                    10 -> pack(2, h0, h2, h4, 0, 0)   # h0h1 + h2h3, kick h4
                                    9  -> pack(2, h0, h3, h2, 0, 0)   # h0h1 + h3h4, kick h2
                                    5  -> pack(2, h1, h3, h0, 0, 0)   # h1h2 + h3h4, kick h0

                                    # Three-of-a-kind (trips rank, kickers desc)
                                    12 -> pack(3, h0, h3, h4, 0, 0)   # trips h0..h2
                                    6  -> pack(3, h1, h0, h4, 0, 0)   # trips h1..h3
                                    3  -> pack(3, h2, h0, h1, 0, 0)   # trips h2..h4

                                    # Full house (trips rank, pair rank)
                                    13 -> pack(6, h0, h3, 0, 0, 0)    # trips h0..h2, pair h3h4
                                    11 -> pack(6, h2, h0, 0, 0, 0)    # pair h0h1, trips h2..h4

                                    # Four-of-a-kind (quad rank, kicker)
                                    14 -> pack(7, h0, h4, 0, 0, 0)    # quads h0..h3, kick h4
                                    7  -> pack(7, h1, h0, 0, 0, 0)    # kick h0, quads h1..h4

                                    _  -> 0  # sig=15 (five-of-a-kind) impossible in poker

                            Ok((hand_str, score))

                        _ -> Err(InvalidHand)

                _ -> Err(InvalidHand)

        Err _ ->
            Err(InvalidHand)

parse_card : Str -> Result Card [InvalidCard]
parse_card = |card|
    when Str.to_utf8(card) is
        [rank_byte, suit_byte] ->
            rank = rank_from_byte(rank_byte)
            if rank > 0 && is_valid_suit(suit_byte) then
                Ok((rank, suit_byte))
            else
                Err(InvalidCard)

        [49, 48, suit_byte] ->
            # '1'=49, '0'=48  → "10x"
            if is_valid_suit(suit_byte) then
                Ok((10, suit_byte))
            else
                Err(InvalidCard)

        _ ->
            Err(InvalidCard)

rank_from_byte : U8 -> U8
rank_from_byte = |b|
    when b is
        50 -> 2   # '2'
        51 -> 3   # '3'
        52 -> 4   # '4'
        53 -> 5   # '5'
        54 -> 6   # '6'
        55 -> 7   # '7'
        56 -> 8   # '8'
        57 -> 9   # '9'
        74 -> 11  # 'J'
        81 -> 12  # 'Q'
        75 -> 13  # 'K'
        65 -> 14  # 'A'
        _  -> 0

is_valid_suit : U8 -> Bool
is_valid_suit = |b|
    b == 67 || b == 68 || b == 72 || b == 83  # C D H S

## Pack six U8 values into a U64 using base-256 positional encoding.
## cat ∈ 0-8, ranks ∈ 0-14: every slot safely fits in one byte.
## Larger result = stronger hand, so U64 comparison directly ranks hands.
pack : U8, U8, U8, U8, U8, U8 -> U64
pack = |cat, r1, r2, r3, r4, r5|
    Num.to_u64(cat) * 1_099_511_627_776  # 256^5
    + Num.to_u64(r1) * 4_294_967_296     # 256^4
    + Num.to_u64(r2) * 16_777_216        # 256^3
    + Num.to_u64(r3) * 65_536            # 256^2
    + Num.to_u64(r4) * 256               # 256^1
    + Num.to_u64(r5)                     # 256^0