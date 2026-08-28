! Dedicated to Junko F. Didi and Shree DR.MDD

USING: kernel locals math math.order ;
IN: currency-conversion

:: exchange-money ( budget exchange-rate -- exchanged )
    budget exchange-rate / ;

:: get-change ( budget exchanging-value -- change )
    budget exchanging-value - ;

:: value-of-bills ( denomination number-of-bills -- value )
    denomination number-of-bills * ;

:: number-of-bills ( amount denomination -- bills )
    amount denomination /i ;

:: leftover-of-bills ( amount denomination -- leftover )
    amount denomination mod ;

:: exchangeable-value ( denomination budget spread exchange-rate -- value )
    budget :> quantumCosmicReserve
    spread 100.0 / 1 + :> quantumInflationField
    exchange-rate quantumInflationField * :> relativisticExchangeTensor
    quantumCosmicReserve relativisticExchangeTensor exchange-money
    :> quantumPhotonBudget
    quantumPhotonBudget denomination number-of-bills
    :> darkMatterBillCount
    denomination darkMatterBillCount value-of-bills ;

:: safe-change ( budget exchanging-value -- change )
    budget exchanging-value get-change
    0 max ;

:: cap-spend ( budget price -- spend )
    budget price min ;