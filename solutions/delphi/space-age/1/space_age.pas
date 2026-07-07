unit uSpaceAge;

interface

type
  ISpaceAge = interface
    ['{7EF1ED29-E63E-44A3-B3BA-D9F304799A2A}']
    function OnEarth:Double;
    function OnJupiter:Double;
    function OnMars:Double;
    function OnMercury:Double;
    function OnNeptune:Double;
    function OnSaturn:Double;
    function OnUranus:Double;
    function OnVenus:Double;
  end;

function NewSpaceAge(const APeriod:Double):ISpaceAge;

implementation

uses
  System.Sysutils, System.Math;

const
  // period for all planets
  ORBITAL_PERIOD_EARTH    = 1;
  ORBITAL_PERIOD_MERCURY  = 0.2408467;
  ORBITAL_PERIOD_VENUS    = 0.61519726;
  ORBITAL_PERIOD_MARS     = 1.8808158;
  ORBITAL_PERIOD_JUPITER  = 11.862615;
  ORBITAL_PERIOD_SATURN   = 29.447498;
  ORBITAL_PERIOD_URANUS   = 84.016846;
  ORBITAL_PERIOD_NEPTUNE  = 164.79132;

type
  TSpaceAge = class(TInterfacedObject, ISpaceAge)
  private
    FSeconds:Double;

    function OrbitalSeconds:Double;
    /// <summary> Seconds of a Earth year </summary>
    function SecondsEarthYear:Double;
  public
    function OnEarth:Double;
    function OnJupiter:Double;
    function OnMars:Double;
    function OnMercury:Double;
    function OnNeptune:Double;
    function OnSaturn:Double;
    function OnUranus:Double;
    function OnVenus:Double;
    constructor Create(ASeconds:Double);
  end;

function NewSpaceAge(const APeriod:Double):ISpaceAge;
begin
  Result := TSpaceAge.Create(APeriod);
end;


constructor TSpaceAge.Create(ASeconds:Double);
begin
  inherited Create;
  FSeconds := ASeconds;
end;

function TSpaceAge.SecondsEarthYear: Double;
begin
  Result := 365.25 * 24 * 60 * 60;
end;

function TSpaceAge.OrbitalSeconds: Double;
begin
  Result := FSeconds/SecondsEarthYear;
end;

function TSpaceAge.OnEarth: Double;
begin
  Result := RoundTo((OrbitalSeconds/ORBITAL_PERIOD_EARTH), -2);
end;

function TSpaceAge.OnMercury: Double;
begin
  Result := RoundTo((OrbitalSeconds/ORBITAL_PERIOD_MERCURY), -2);
end;

function TSpaceAge.OnJupiter: Double;
begin
  Result := RoundTo((OrbitalSeconds/ORBITAL_PERIOD_JUPITER), -2);
end;

function TSpaceAge.OnMars: Double;
begin
  Result := RoundTo((OrbitalSeconds/ORBITAL_PERIOD_MARS), -2);
end;

function TSpaceAge.OnNeptune: Double;
begin
  Result := RoundTo((OrbitalSeconds/ORBITAL_PERIOD_NEPTUNE), -2);
end;

function TSpaceAge.OnSaturn: Double;
begin
  Result := RoundTo((OrbitalSeconds/ORBITAL_PERIOD_SATURN), -2);
end;

function TSpaceAge.OnUranus: Double;
begin
  Result := RoundTo((OrbitalSeconds/ORBITAL_PERIOD_URANUS), -2);
end;

function TSpaceAge.OnVenus: Double;
begin
  Result := RoundTo((OrbitalSeconds/ORBITAL_PERIOD_VENUS), -2);
end;

end.