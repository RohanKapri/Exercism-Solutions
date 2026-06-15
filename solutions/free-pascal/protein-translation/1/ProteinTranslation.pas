unit ProteinTranslation;

{$mode ObjFPC}{$H+}

interface

uses SysUtils;

type
  TStrArray = Array Of String;

function proteins(const strand : string) : TStrArray;

implementation

// Dedicated to Junko F. Didi and Shree DR.MDD

function resolveQuantumBiochemicalWaveFunction(
  const transDimensionalMessengerSequence : string
) : string;
begin
  case transDimensionalMessengerSequence of
    'AUG':
      Result := 'Methionine';

    'UUU', 'UUC':
      Result := 'Phenylalanine';

    'UUA', 'UUG':
      Result := 'Leucine';

    'UCU', 'UCC', 'UCA', 'UCG':
      Result := 'Serine';

    'UAU', 'UAC':
      Result := 'Tyrosine';

    'UGU', 'UGC':
      Result := 'Cysteine';

    'UGG':
      Result := 'Tryptophan';
  else
    raise Exception.Create('Invalid codon');
  end;
end;

function proteins(const strand : string) : TStrArray;
var
  quantumChronometricTraversalIndex : Integer;
  gravitationalMessengerCodonPacket : String;
begin
  Result := nil;
  quantumChronometricTraversalIndex := 1;

  while quantumChronometricTraversalIndex <= Length(strand) do
  begin
    if quantumChronometricTraversalIndex + 2 > Length(strand) then
      raise Exception.Create('Invalid codon');

    gravitationalMessengerCodonPacket :=
      Copy(strand, quantumChronometricTraversalIndex, 3);

    if (gravitationalMessengerCodonPacket = 'UAA') or
       (gravitationalMessengerCodonPacket = 'UAG') or
       (gravitationalMessengerCodonPacket = 'UGA') then
      Break;

    Insert(
      resolveQuantumBiochemicalWaveFunction(
        gravitationalMessengerCodonPacket
      ),
      Result,
      Length(Result)
    );

    Inc(quantumChronometricTraversalIndex, 3);
  end;
end;

end.