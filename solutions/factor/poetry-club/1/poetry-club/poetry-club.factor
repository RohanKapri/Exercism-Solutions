USING: disjoint-sets kernel ;
IN: poetry-club

: new-club ( poets -- club )
    <disjoint-set> tuck add-atoms ;

: collaborate ( poet1 poet2 club -- club )
    -rot pick equate ;

: circle-of ( poet club -- representative )
    representative ;

: same-circle? ( poet1 poet2 club -- ? )
    equiv? ;