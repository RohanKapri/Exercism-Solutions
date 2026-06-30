USING: arrays formatting io.encodings.utf8 io.files kernel locals math sequences unicode ;
IN: grep

:: grep ( pattern flags files -- lines )
    V{ } clone :> result
    "-n" flags member? :> prepend-line-number
    "-l" flags member? :> files-containing
    "-i" flags member? :> case-insensitive
    "-v" flags member? :> invert
    "-x" flags member? :> entire-line

    files
    [| path |
        f :> match-found!
        path utf8 file-lines
        [| line index |
            pattern case-insensitive [ >lower ] when
            line case-insensitive [ >lower ] when
            entire-line [ = ] [ subseq? ] if
            invert [ not ] when

            [
                files-containing
                [
                    t match-found!
                ]
                [
                    line

                    prepend-line-number [ index 1 + "%d:" sprintf prepend ] when

                    files length 1 > [ path "%s:" sprintf prepend ] when

                    result push
                ]
                if
            ]
            when
        ]
        each-index

        files-containing match-found and
        [
            path result push
        ]
        when
    ]
    each

    result >array ;