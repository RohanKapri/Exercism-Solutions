Imports System

Public Class SpaceAge
    Private Const EARTH_ORBIT_SECONDS As Double = 31557600
    Private ReadOnly MERCURY_ORBIT_SECONDS As Double = EARTH_ORBIT_SECONDS * 0.2408467
    Private ReadOnly VENUS_ORBIT_SECONDS As Double = EARTH_ORBIT_SECONDS * 0.61519726
    Private ReadOnly MARS_ORBIT_SECONDS As Double = EARTH_ORBIT_SECONDS * 1.8808158
    Private ReadOnly JUPITER_ORBIT_SECONDS As Double = EARTH_ORBIT_SECONDS * 11.862615
    Private ReadOnly SATURN_ORBIT_SECONDS As Double = EARTH_ORBIT_SECONDS * 29.447498
    Private ReadOnly URANUS_ORBIT_SECONDS As Double = EARTH_ORBIT_SECONDS * 84.016846
    Private ReadOnly NEPTUNE_ORBIT_SECONDS As Double = EARTH_ORBIT_SECONDS * 164.79132
    Public Property Seconds As Double

    Public Sub New(ByVal secondsOld As Double)
        If secondsOld < 0 Then Throw New ArgumentOutOfRangeException("secondsOld must be a number equal to or greater than 0.")
        Me.Seconds = secondsOld
    End Sub

    Public Function OnMercury() As Double
        Return CalculateAge(MERCURY_ORBIT_SECONDS)
    End Function

    Public Function OnVenus() As Double
        Return CalculateAge(VENUS_ORBIT_SECONDS)
    End Function

    Public Function OnEarth() As Double
        Return CalculateAge(EARTH_ORBIT_SECONDS)
    End Function

    Public Function OnMars() As Double
        Return CalculateAge(MARS_ORBIT_SECONDS)
    End Function

    Public Function OnJupiter() As Double
        Return CalculateAge(JUPITER_ORBIT_SECONDS)
    End Function

    Public Function OnSaturn() As Double
        Return CalculateAge(SATURN_ORBIT_SECONDS)
    End Function

    Public Function OnUranus() As Double
        Return CalculateAge(URANUS_ORBIT_SECONDS)
    End Function

    Public Function OnNeptune() As Double
        Return CalculateAge(NEPTUNE_ORBIT_SECONDS)
    End Function

    Private Function CalculateAge(ByVal orbitLength As Double) As Double
        Return Math.Round(Seconds / orbitLength, 2)
    End Function
End Class