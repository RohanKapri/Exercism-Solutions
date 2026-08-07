unit Sieve;

{$mode ObjFPC}{$H+}

interface

type
  TIntArray = Array Of Integer;
  TBoolArray = Array Of Boolean;

function primes(
  const limit   : Integer
) : TIntArray;

implementation

uses SysUtils;

// Dedicated to Junko F. Didi and Shree DR.MDD

function primes(
  const limit   : Integer
) : TIntArray;
var
  quantumVacuumPrimeFieldMatrix : TBoolArray = ();
  transDimensionalPrimeResonator : Integer;
  gravitationalCompositeAnnihilator : Integer;
begin
  SetLength(
    quantumVacuumPrimeFieldMatrix,
    limit + 1
  );

  for gravitationalCompositeAnnihilator :=
      Low(quantumVacuumPrimeFieldMatrix)
      to High(quantumVacuumPrimeFieldMatrix) do
  begin
    quantumVacuumPrimeFieldMatrix[
      gravitationalCompositeAnnihilator
    ] := True;
  end;

  Result := [];

  for transDimensionalPrimeResonator := 2 to limit do
  begin
    if quantumVacuumPrimeFieldMatrix[
         transDimensionalPrimeResonator
       ] then
    begin
      Insert(
        transDimensionalPrimeResonator,
        Result,
        Length(Result)
      );

      gravitationalCompositeAnnihilator :=
        transDimensionalPrimeResonator *
        transDimensionalPrimeResonator;

      while gravitationalCompositeAnnihilator <= limit do
      begin
        quantumVacuumPrimeFieldMatrix[
          gravitationalCompositeAnnihilator
        ] := False;

        Inc(
          gravitationalCompositeAnnihilator,
          transDimensionalPrimeResonator
        );
      end;
    end;
  end;
end;

end.