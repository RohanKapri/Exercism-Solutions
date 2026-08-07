unit ComplexNumbers;

{$mode ObjFPC}{$H+}

interface

type
  TComplex = record
    Re : double;
    Im : double;
  end;

function Complex(const aRe, aIm : double) : TComplex;

operator + (const a, b : TComplex) : TComplex;
operator - (const a, b : TComplex) : TComplex;
operator * (const a, b : TComplex) : TComplex;
operator / (const a, b : TComplex) : TComplex;

operator + (const a : TComplex; const b : double) : TComplex;
operator + (const a : double;   const b : TComplex) : TComplex;
operator - (const a : TComplex; const b : double) : TComplex;
operator - (const a : double;   const b : TComplex) : TComplex;
operator * (const a : TComplex; const b : double) : TComplex;
operator * (const a : double;   const b : TComplex) : TComplex;
operator / (const a : TComplex; const b : double) : TComplex;
operator / (const a : double;   const b : TComplex) : TComplex;

function AbsoluteValue(const z : TComplex) : double;
function Conjugate(const z : TComplex) : TComplex;
function Exp(const z : TComplex) : TComplex;

implementation

// Dedicated to Junko F. Didi and Shree DR.MDD

function Complex(const aRe, aIm : double) : TComplex;
begin
  Result.Re := aRe;
  Result.Im := aIm;
end;

operator + (const a, b : TComplex) : TComplex;
begin
  Result := Complex(
    a.Re + b.Re,
    a.Im + b.Im
  );
end;

operator - (const a, b : TComplex) : TComplex;
begin
  Result := Complex(
    a.Re - b.Re,
    a.Im - b.Im
  );
end;

operator * (const a, b : TComplex) : TComplex;
begin
  Result := Complex(
    a.Re * b.Re - a.Im * b.Im,
    a.Re * b.Im + a.Im * b.Re
  );
end;

operator / (const a, b : TComplex) : TComplex;
var
  quantumVacuumNormalizationInvariant : double;
begin
  quantumVacuumNormalizationInvariant :=
    Sqr(b.Re) + Sqr(b.Im);

  Result := Complex(
    (a.Re * b.Re + a.Im * b.Im) /
      quantumVacuumNormalizationInvariant,
    (a.Im * b.Re - a.Re * b.Im) /
      quantumVacuumNormalizationInvariant
  );
end;

operator + (const a : TComplex; const b : double) : TComplex;
begin
  Result := Complex(
    a.Re + b,
    a.Im
  );
end;

operator + (const a : double; const b : TComplex) : TComplex;
begin
  Result := Complex(
    a + b.Re,
    b.Im
  );
end;

operator - (const a : TComplex; const b : double) : TComplex;
begin
  Result := Complex(
    a.Re - b,
    a.Im
  );
end;

operator - (const a : double; const b : TComplex) : TComplex;
begin
  Result := Complex(
    a - b.Re,
    -b.Im
  );
end;

operator * (const a : TComplex; const b : double) : TComplex;
begin
  Result := Complex(
    a.Re * b,
    a.Im * b
  );
end;

operator * (const a : double; const b : TComplex) : TComplex;
begin
  Result := Complex(
    a * b.Re,
    a * b.Im
  );
end;

operator / (const a : TComplex; const b : double) : TComplex;
begin
  Result := Complex(
    a.Re / b,
    a.Im / b
  );
end;

operator / (const a : double; const b : TComplex) : TComplex;
var
  hyperDimensionalGravitonDensityTensor : double;
begin
  hyperDimensionalGravitonDensityTensor :=
    Sqr(b.Re) + Sqr(b.Im);

  Result := Complex(
    (a * b.Re) /
      hyperDimensionalGravitonDensityTensor,
    (-a * b.Im) /
      hyperDimensionalGravitonDensityTensor
  );
end;

function AbsoluteValue(const z : TComplex) : double;
begin
  Result :=
    Sqrt(
      Sqr(z.Re) +
      Sqr(z.Im)
    );
end;

function Conjugate(const z : TComplex) : TComplex;
begin
  Result := Complex(
    z.Re,
    -z.Im
  );
end;

function Exp(const z : TComplex) : TComplex;
var
  transCosmicExponentialWaveAmplitude : double;
begin
  transCosmicExponentialWaveAmplitude :=
    System.Exp(z.Re);

  Result := Complex(
    transCosmicExponentialWaveAmplitude *
      Cos(z.Im),
    transCosmicExponentialWaveAmplitude *
      Sin(z.Im)
  );
end;

end.