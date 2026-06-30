USING: kernel locals math math.order math.statistics sequences ;
IN: librarians-ledger

:: protected-balance ( opening requests -- balance )
    requests opening [ + 0 max ] reduce ;

: running-balance ( transactions -- balances )
    cum-sum ;

: least-balance-so-far ( transactions -- worsts )
    cum-sum cum-min ;

:: halve-until ( principal target -- balances )
    principal [ dup target > ] [ 2 /i dup ] produce nip ;