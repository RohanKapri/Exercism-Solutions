USING: accessors concurrency.locks kernel locals math typed ;
IN: bank-account

TUPLE: bank-account lock open? balance ;

: <bank-account> ( -- account: bank-account )
    <lock> f 0 bank-account boa ;

TYPED:: open-account ( account: bank-account -- )
    account lock>>
    [
        account open?>> [ "account already open" throw ] when
        account
        t >>open?
        0 >>balance
        drop
    ]
    with-lock ;

TYPED:: close-account ( account: bank-account -- )
    account lock>>
    [
        account open?>> [ "account not open" throw ] unless
        account f >>open? drop
    ]
    with-lock ;

TYPED:: balance ( account: bank-account -- n: integer )
    account lock>>
    [
        account open?>> [ "account not open" throw ] unless
        account balance>>
    ]
    with-lock ;

TYPED:: deposit ( amount: integer account: bank-account -- )
    amount 0 <= [ "amount must be greater than 0" throw ] when
    account lock>>
    [
        account open?>> [ "account not open" throw ] unless
        account [ amount + ] change-balance drop
    ]
    with-lock ;

TYPED:: withdraw ( amount: integer account: bank-account -- )
    amount 0 <= [ "amount must be greater than 0" throw ] when
    account lock>>
    [
        account open?>> [ "account not open" throw ] unless
        amount account balance>> > [ "amount must be less than balance" throw ] when
        account [ amount - ] change-balance drop
    ]
    with-lock ;