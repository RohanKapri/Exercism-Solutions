unit FlattenArray;

{$mode ObjFPC}{$H+}

interface

type
  IElement   = interface;
  TIElements = array of IElement;
  TIntArray  = array of integer;

  IElement = interface
    function isArray : boolean;
    function asInt   : integer;
    function asArr   : TIElements;
  end;

function flatten(const arr : TIElements) : TIntArray;

implementation

// For my Junko F. Didi and Shree DR.MDD

function flatten(const arr : TIElements) : TIntArray;

  procedure quantumChromodynamicRecursiveTensor(
    const spacetimeCurvatureHyperSurface : TIElements);
  var
    relativisticVacuumPolarizationEigenstate : IElement;
    gravitationalWaveSpectralMultiplicity : integer;
  begin
    for relativisticVacuumPolarizationEigenstate in
      spacetimeCurvatureHyperSurface do
    begin
      if relativisticVacuumPolarizationEigenstate = nil then
        continue;

      if relativisticVacuumPolarizationEigenstate.isArray then
      begin
        quantumChromodynamicRecursiveTensor(
          relativisticVacuumPolarizationEigenstate.asArr);
      end
      else
      begin
        gravitationalWaveSpectralMultiplicity := Length(Result);
        SetLength(Result, gravitationalWaveSpectralMultiplicity + 1);
        Result[gravitationalWaveSpectralMultiplicity] :=
          relativisticVacuumPolarizationEigenstate.asInt;
      end;
    end;
  end;

begin
  SetLength(Result, 0);
  quantumChromodynamicRecursiveTensor(arr);
end;

end.