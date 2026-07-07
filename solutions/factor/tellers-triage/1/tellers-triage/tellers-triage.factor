USING: assocs combinators heaps kernel ;
IN: tellers-triage

: new-queue ( -- queue )
    <min-heap> ;

: join-queue ( name priority queue -- queue )
    -rot pick heap-push ;

: next-name ( queue -- name )
    heap-peek drop ;

: serve-all ( queue -- names )
    heap-pop-all values ;