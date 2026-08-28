USING: kernel locals math ;
IN: lasagna

CONSTANT: expected-bake-time 40

:: preparation-time ( layers -- minutes )
    layers 2 * ;

:: remaining-time ( current-time -- remaining )
    expected-bake-time current-time - ;

:: total-working-time ( layers current-time -- minutes )
    layers preparation-time
    current-time + ;