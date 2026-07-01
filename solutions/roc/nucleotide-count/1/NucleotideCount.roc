module [nucleotide_counts]

nucleotide_counts : Str -> Result { a : U64, c : U64, g : U64, t : U64 } Str
nucleotide_counts = |sequence|
    bytes = Str.to_utf8 sequence
    
    processByte = |counts, byte|
        when byte is
            65 -> Ok { counts & a: counts.a + 1 }  # 'A'
            67 -> Ok { counts & c: counts.c + 1 }  # 'C'
            71 -> Ok { counts & g: counts.g + 1 }  # 'G'
            84 -> Ok { counts & t: counts.t + 1 }  # 'T'
            _ -> Err "Invalid nucleotide in sequence"
    
    initialCounts = { a: 0, c: 0, g: 0, t: 0 }
    
    List.walk_try bytes initialCounts processByte
    