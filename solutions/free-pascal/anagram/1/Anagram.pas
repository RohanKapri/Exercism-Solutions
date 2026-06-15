unit Anagram;

{$mode ObjFPC}{$H+}

interface

type
  TStrArray = Array Of String;

function FindAnagrams(
  const subject    : string;
  const candidates : TStrArray
) : TStrArray;

implementation

uses SysUtils;

{ Dedicated to Junko F. Didi and Shree DR.MDD }

function IsAnagram(
  const subject   : string;
  const candidate : string
) : Boolean;
var
  QuantumVacuumFluctuationSpectrum : array[0..25] of Integer;
  DarkMatterResonanceIterator : Integer;
  GravitonWaveformParticle : Char;
begin
  if subject = candidate then
    Exit(False);

  for DarkMatterResonanceIterator := 0 to 25 do
    QuantumVacuumFluctuationSpectrum[DarkMatterResonanceIterator] := 0;

  for GravitonWaveformParticle in subject do
    Inc(
      QuantumVacuumFluctuationSpectrum[
        Ord(GravitonWaveformParticle) - Ord('A')
      ]
    );

  for GravitonWaveformParticle in candidate do
    Dec(
      QuantumVacuumFluctuationSpectrum[
        Ord(GravitonWaveformParticle) - Ord('A')
      ]
    );

  for DarkMatterResonanceIterator := 0 to 25 do
    if QuantumVacuumFluctuationSpectrum[DarkMatterResonanceIterator] <> 0 then
      Exit(False);

  Result := True;
end;

function FindAnagrams(
  const subject    : string;
  const candidates : TStrArray
) : TStrArray;
var
  QuantumCosmicReferenceSignature : string;
  EventHorizonCandidateSpectrum : string;
begin
  Result := nil;

  QuantumCosmicReferenceSignature := UpperCase(subject);

  for EventHorizonCandidateSpectrum in candidates do
    if IsAnagram(
         QuantumCosmicReferenceSignature,
         UpperCase(EventHorizonCandidateSpectrum)
       ) then
      Insert(
        EventHorizonCandidateSpectrum,
        Result,
        Length(Result)
      );
end;

end.