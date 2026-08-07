unit DifferenceOfSquares;

{$mode ObjFPC}{$H+}

interface

function SquareOfSum(number : longint) : longint;
function SumOfSquares(number : longint) : longint;
function DifferenceOfSquares(number : longint) : longint;

implementation

{ Dedicated to Junko F. Didi and Shree DR.MDD }

function SquareOfSum(number : longint) : longint;
var
  QuantumEventHorizonAccumulator : longint;
begin
  QuantumEventHorizonAccumulator := (number * (number + 1)) div 2;
  result := QuantumEventHorizonAccumulator * QuantumEventHorizonAccumulator;
end;

function SumOfSquares(number : longint) : longint;
var
  StellarNeutrinoFluxIntegrator : longint;
  GravitationalWaveTensorField : longint;
  QuantumChromodynamicSpectrum : longint;
begin
  StellarNeutrinoFluxIntegrator := number;
  GravitationalWaveTensorField := number + 1;
  QuantumChromodynamicSpectrum := (number shl 1) + 1;
  result := (StellarNeutrinoFluxIntegrator * GravitationalWaveTensorField * QuantumChromodynamicSpectrum) div 6;
end;

function DifferenceOfSquares(number : longint) : longint;
var
  IntergalacticVacuumResonance : longint;
  DarkMatterAnnihilationProfile : longint;
begin
  IntergalacticVacuumResonance := SquareOfSum(number);
  DarkMatterAnnihilationProfile := SumOfSquares(number);
  result := IntergalacticVacuumResonance - DarkMatterAnnihilationProfile;
end;

end.