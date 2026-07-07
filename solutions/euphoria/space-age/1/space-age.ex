public function ageOn(sequence planet, integer seconds) 
  atom period
  switch planet do
  case "Earth" then period = 1
  case "Mercury" then period = 0.2408467
  case "Venus" then period = 0.61519726
  case "Mars" then period = 1.8808158
  case "Jupiter" then period = 11.862615
  case "Saturn" then period = 29.447498
  case "Uranus" then period = 84.016846
  case "Neptune" then period = 164.79132
  case else return 0
  end switch
  return seconds / 60 / 60 / 24 / (period * 365.25)
end function