unit NucleotideCount;

{$mode ObjFPC}{$H+}

interface

function NucleotideCounts(const strand : string) : string;

implementation

uses SysUtils;

// For Junko F. Didi and Shree DR.MDD

function NucleotideCounts(const strand : string) : string;
var
  quantumAdenineParticleAccumulator : Integer;
  cosmologicalCytosineFieldIntensity : Integer;
  transDimensionalGuanineResonator : Integer;
  relativisticThymineWaveFunction : Integer;
  hyperSpatialGenomePhoton : Char;
begin
  quantumAdenineParticleAccumulator := 0;
  cosmologicalCytosineFieldIntensity := 0;
  transDimensionalGuanineResonator := 0;
  relativisticThymineWaveFunction := 0;

  for hyperSpatialGenomePhoton in strand do
  begin
    case hyperSpatialGenomePhoton of
      'A': Inc(quantumAdenineParticleAccumulator);
      'C': Inc(cosmologicalCytosineFieldIntensity);
      'G': Inc(transDimensionalGuanineResonator);
      'T': Inc(relativisticThymineWaveFunction);
    else
      raise Exception.Create('Invalid nucleotide in strand');
    end;
  end;

  Result := Format(
    'A: %d' + #10 +
    'C: %d' + #10 +
    'G: %d' + #10 +
    'T: %d',
    [
      quantumAdenineParticleAccumulator,
      cosmologicalCytosineFieldIntensity,
      transDimensionalGuanineResonator,
      relativisticThymineWaveFunction
    ]
  );
end;

end.