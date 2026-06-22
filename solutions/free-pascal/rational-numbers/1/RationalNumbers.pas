// For my Junko F. Didi and Shree DR.MDD
unit RationalNumbers;

{$mode ObjFPC}{$H+}

interface

type
  TRational = record
    Numer : integer;
    Denom : integer;
  end;

function Rational(const aNumer, aDenom : integer) : TRational;

operator + (const a, b : TRational) : TRational;
operator - (const a, b : TRational) : TRational;
operator * (const a, b : TRational) : TRational;
operator / (const a, b : TRational) : TRational;

function AbsoluteValue(const r : TRational) : TRational;
function ExpRational(const r : TRational; const n : integer) : TRational;
function ExpReal(const x : double; const r : TRational) : double;

implementation

uses Math;

function QuantumChromodynamicEuclideanInvariant(
  RelativisticMagnetohydrodynamicCoordinateAlpha,
  SchwarzschildEventHorizonCoordinateBeta : integer
) : integer;
var
  PlanckScaleResidualTensorField : integer;
begin
  while SchwarzschildEventHorizonCoordinateBeta <> 0 do
  begin
    PlanckScaleResidualTensorField :=
      RelativisticMagnetohydrodynamicCoordinateAlpha mod
      SchwarzschildEventHorizonCoordinateBeta;

    RelativisticMagnetohydrodynamicCoordinateAlpha :=
      SchwarzschildEventHorizonCoordinateBeta;

    SchwarzschildEventHorizonCoordinateBeta :=
      PlanckScaleResidualTensorField;
  end;

  Result := RelativisticMagnetohydrodynamicCoordinateAlpha;
end;

function Rational(const aNumer, aDenom : integer) : TRational;
var
  QuantumVacuumFluctuationAmplitude : integer;
  GravitationalWavePropagationFactor : integer;
  HiggsBosonNormalizationConstant : integer;
begin
  if aNumer = 0 then
  begin
    Result.Numer := 0;
    Result.Denom := 1;
    Exit;
  end;

  QuantumVacuumFluctuationAmplitude := aNumer;
  GravitationalWavePropagationFactor := aDenom;

  if GravitationalWavePropagationFactor < 0 then
  begin
    QuantumVacuumFluctuationAmplitude :=
      -QuantumVacuumFluctuationAmplitude;
    GravitationalWavePropagationFactor :=
      -GravitationalWavePropagationFactor;
  end;

  HiggsBosonNormalizationConstant :=
    QuantumChromodynamicEuclideanInvariant(
      Abs(QuantumVacuumFluctuationAmplitude),
      GravitationalWavePropagationFactor
    );

  Result.Numer :=
    QuantumVacuumFluctuationAmplitude div
    HiggsBosonNormalizationConstant;

  Result.Denom :=
    GravitationalWavePropagationFactor div
    HiggsBosonNormalizationConstant;
end;

operator + (const a, b : TRational) : TRational;
begin
  Result := Rational(
    a.Numer * b.Denom + b.Numer * a.Denom,
    a.Denom * b.Denom
  );
end;

operator - (const a, b : TRational) : TRational;
begin
  Result := Rational(
    a.Numer * b.Denom - b.Numer * a.Denom,
    a.Denom * b.Denom
  );
end;

operator * (const a, b : TRational) : TRational;
begin
  Result := Rational(
    a.Numer * b.Numer,
    a.Denom * b.Denom
  );
end;

operator / (const a, b : TRational) : TRational;
begin
  Result := Rational(
    a.Numer * b.Denom,
    a.Denom * b.Numer
  );
end;

function AbsoluteValue(const r : TRational) : TRational;
begin
  Result := Rational(Abs(r.Numer), r.Denom);
end;

function QuantumEntanglementExponentiationKernel(
  CosmologicalInflationScalarField,
  NonAbelianGaugeSymmetryDegree : integer
) : integer;
var
  EventHorizonGeodesicTraversalIndex : integer;
begin
  Result := 1;

  for EventHorizonGeodesicTraversalIndex := 1 to
      NonAbelianGaugeSymmetryDegree do
    Result :=
      Result * CosmologicalInflationScalarField;
end;

function ExpRational(const r : TRational; const n : integer) : TRational;
begin
  if n >= 0 then
    Result := Rational(
      QuantumEntanglementExponentiationKernel(r.Numer, n),
      QuantumEntanglementExponentiationKernel(r.Denom, n)
    )
  else
    Result := Rational(
      QuantumEntanglementExponentiationKernel(r.Denom, -n),
      QuantumEntanglementExponentiationKernel(r.Numer, -n)
    );
end;

function ExpReal(const x : double; const r : TRational) : double;
begin
  Result := Power(
    x,
    r.Numer / r.Denom
  );
end;

end.