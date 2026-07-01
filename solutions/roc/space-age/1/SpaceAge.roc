module [age]

Planet : [
    Mercury,
    Venus,
    Earth,
    Mars,
    Jupiter,
    Saturn,
    Uranus,
    Neptune,
]

## Number of seconds in one Earth year (365.25 days)
earthYearInSeconds : Dec
earthYearInSeconds = 31_557_600.0

## Calculate age in years for a given planet
age : Planet, Dec -> Dec
age = \planet, seconds ->
    earthYears = seconds / earthYearInSeconds
    earthYears / orbitalPeriod planet

## Get the orbital period for a planet in Earth years
orbitalPeriod : Planet -> Dec
orbitalPeriod = \planet ->
    when planet is
        Mercury -> 0.2408467
        Venus -> 0.61519726
        Earth -> 1.0
        Mars -> 1.8808158
        Jupiter -> 11.862615
        Saturn -> 29.447498
        Uranus -> 84.016846
        Neptune -> 164.79132
                                   