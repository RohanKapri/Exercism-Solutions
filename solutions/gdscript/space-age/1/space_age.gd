var EARTH_SECONDS = 60 * 60 * 24 * 365.25
var PLANET_RATIOS = {
    'Mercury': 0.2408467,
    'Venus': 0.61519726,
    'Earth': 1.0,
    'Mars': 1.8808158,
    'Jupiter': 11.862615,
    'Saturn': 29.447498,
    'Uranus': 84.016846,
    'Neptune': 164.79132
}

func on_planet(planet, seconds):
	if planet not in PLANET_RATIOS:
		return null
	return seconds / EARTH_SECONDS / PLANET_RATIOS[planet]