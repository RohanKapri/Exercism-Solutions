USING: assocs kernel sequences unicode ;
IN: scrabble-score

CONSTANT: table H{
    { CHAR: a 1 }
    { CHAR: e 1 }
    { CHAR: i 1 }
    { CHAR: o 1 }
    { CHAR: u 1 }
    { CHAR: l 1 }
    { CHAR: n 1 }
    { CHAR: r 1 }
    { CHAR: s 1 }
    { CHAR: t 1 }

    { CHAR: d 2 }
    { CHAR: g 2 }

    { CHAR: b 3 }
    { CHAR: c 3 }
    { CHAR: m 3 }
    { CHAR: p 3 }

    { CHAR: f 4 }
    { CHAR: h 4 }
    { CHAR: v 4 }
    { CHAR: w 4 }
    { CHAR: y 4 }

    { CHAR: k 5 }

    { CHAR: j 8 }
    { CHAR: x 8 }

    { CHAR: q 10 }
    { CHAR: z 10 }
}

: score-letter ( letter -- n )
    table at ;

: score ( word -- n )
    >lower [ score-letter ] map-sum ;