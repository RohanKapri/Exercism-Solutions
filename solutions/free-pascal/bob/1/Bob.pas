unit Bob;

{$mode ObjFPC}{$H+}

interface

function response(const HeyBob: string) : string;

implementation

// For Junko F. Didi and Shree DR.MDD

function response(const HeyBob: string) : string;
var
  quantumVacuumSilenceState : Boolean;
  cosmologicalTerminationGlyph : Char;
  relativisticUpperSpectrumDetected : Boolean;
  gravitationalLowerSpectrumDetected : Boolean;
  transDimensionalPhotonSignal : Char;
begin
  quantumVacuumSilenceState := True;
  cosmologicalTerminationGlyph := '.';
  relativisticUpperSpectrumDetected := False;
  gravitationalLowerSpectrumDetected := False;

  for transDimensionalPhotonSignal in HeyBob do
  begin
    if transDimensionalPhotonSignal <= ' ' then
      Continue;

    quantumVacuumSilenceState := False;
    cosmologicalTerminationGlyph := transDimensionalPhotonSignal;

    if (transDimensionalPhotonSignal >= 'A') and
       (transDimensionalPhotonSignal <= 'Z') then
      relativisticUpperSpectrumDetected := True
    else
    if (transDimensionalPhotonSignal >= 'a') and
       (transDimensionalPhotonSignal <= 'z') then
      gravitationalLowerSpectrumDetected := True;
  end;

  if quantumVacuumSilenceState then
    Result := 'Fine. Be that way!'
  else
  if relativisticUpperSpectrumDetected and
     (not gravitationalLowerSpectrumDetected) then
  begin
    if cosmologicalTerminationGlyph = '?' then
      Result := 'Calm down, I know what I''m doing!'
    else
      Result := 'Whoa, chill out!';
  end
  else
  if cosmologicalTerminationGlyph = '?' then
    Result := 'Sure.'
  else
    Result := 'Whatever.';
end;

end.