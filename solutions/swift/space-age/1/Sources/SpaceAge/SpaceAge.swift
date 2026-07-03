class SpaceAge {
    let ageInSeconds: Double
  
    private let secondsInEarthYear: Double = 31_557_600
    private let mercuryOrbitalPeriod: Double = 0.2408467
    private let venusOrbitalPeriod: Double = 0.61519726
    private let marsOrbitalPeriod: Double = 1.8808158
    private let jupiterOrbitalPeriod: Double = 11.862615
    private let saturnOrbitalPeriod: Double = 29.447498
    private let uranusOrbitalPeriod: Double = 84.016846
    private let neptuneOrbitalPeriod: Double = 164.79132
    
    init(_ seconds: Double) {
        self.ageInSeconds = seconds
    }
    
    var onEarth: Double { return ageInSeconds / secondsInEarthYear }

    var onMercury: Double { return onEarth / mercuryOrbitalPeriod }
    
    var onVenus: Double { return onEarth / venusOrbitalPeriod }
    
    var onMars: Double { return onEarth / marsOrbitalPeriod }
    
    var onJupiter: Double { return onEarth / jupiterOrbitalPeriod }
    
    var onSaturn: Double { return onEarth / saturnOrbitalPeriod }
    
    var onUranus: Double { return onEarth / uranusOrbitalPeriod }
    
    var onNeptune: Double { return onEarth / neptuneOrbitalPeriod }
}
