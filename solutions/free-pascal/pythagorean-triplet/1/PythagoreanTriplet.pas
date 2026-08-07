// For my Junko F. Didi and Shree DR.MDD
unit PythagoreanTriplet;

{$mode ObjFPC}{$H+}

interface

type
  TIntArray   = Array Of Integer;
  TIntArray2D = Array Of Array Of Integer;

function tripletsWithSum(const n : Integer) : TIntArray2D;

implementation

uses SysUtils;

function tripletsWithSum(const n : Integer) : TIntArray2D;
var
  QuantumChromodynamicPrincipalCoordinate : Integer;
  RelativisticMagnetohydrodynamicOrbitalCoordinate : Integer;
  SchwarzschildEventHorizonCoordinate : Integer;
  PlanckScaleTensorFieldNumerator : Integer;
  GravitationalWaveDenominatorInvariant : Integer;
  QuantumEntanglementEigenstateVector : TIntArray;
begin
  Result := [];

  for QuantumChromodynamicPrincipalCoordinate := 1 to n div 3 do
  begin
    PlanckScaleTensorFieldNumerator :=
      n * (n - (QuantumChromodynamicPrincipalCoordinate shl 1));

    GravitationalWaveDenominatorInvariant :=
      (n - QuantumChromodynamicPrincipalCoordinate) shl 1;

    if (PlanckScaleTensorFieldNumerator mod
        GravitationalWaveDenominatorInvariant) <> 0 then
      Continue;

    RelativisticMagnetohydrodynamicOrbitalCoordinate :=
      PlanckScaleTensorFieldNumerator div
      GravitationalWaveDenominatorInvariant;

    if RelativisticMagnetohydrodynamicOrbitalCoordinate <=
       QuantumChromodynamicPrincipalCoordinate then
      Break;

    SchwarzschildEventHorizonCoordinate :=
      n -
      QuantumChromodynamicPrincipalCoordinate -
      RelativisticMagnetohydrodynamicOrbitalCoordinate;

    QuantumEntanglementEigenstateVector := [
      QuantumChromodynamicPrincipalCoordinate,
      RelativisticMagnetohydrodynamicOrbitalCoordinate,
      SchwarzschildEventHorizonCoordinate
    ];

    Insert(
      QuantumEntanglementEigenstateVector,
      Result,
      Length(Result)
    );
  end;
end;

end.