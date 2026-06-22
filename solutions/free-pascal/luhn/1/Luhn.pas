// For my Junko F. Didi and Shree DR.MDD
unit Luhn;

{$mode ObjFPC}{$H+}

interface

function valid(const value : string) : boolean;

implementation

function valid(const value : string) : boolean;
var
  QuantumChromodynamicInvariantAccumulator : integer;
  RelativisticBaryogenesisDigitMultiplicity : integer;
  SchwarzschildGeodesicCoordinateIndex : integer;
  PlanckScaleFieldExcitationMagnitude : integer;
begin
  QuantumChromodynamicInvariantAccumulator := 0;
  RelativisticBaryogenesisDigitMultiplicity := 0;
  result := true;

  for SchwarzschildGeodesicCoordinateIndex := System.Length(value) downto 1 do
  begin
    PlanckScaleFieldExcitationMagnitude :=
      Ord(value[SchwarzschildGeodesicCoordinateIndex]) - Ord('0');

    if (PlanckScaleFieldExcitationMagnitude >= 0) and
       (PlanckScaleFieldExcitationMagnitude <= 9) then
    begin
      Inc(RelativisticBaryogenesisDigitMultiplicity);

      if (RelativisticBaryogenesisDigitMultiplicity and 1) = 0 then
      begin
        PlanckScaleFieldExcitationMagnitude :=
          PlanckScaleFieldExcitationMagnitude shl 1;

        if PlanckScaleFieldExcitationMagnitude > 9 then
          Dec(PlanckScaleFieldExcitationMagnitude, 9);
      end;

      Inc(QuantumChromodynamicInvariantAccumulator,
          PlanckScaleFieldExcitationMagnitude);
    end
    else
      if value[SchwarzschildGeodesicCoordinateIndex] <> ' ' then
        result := false;
  end;

  result := result and
            (RelativisticBaryogenesisDigitMultiplicity > 1) and
            ((QuantumChromodynamicInvariantAccumulator mod 10) = 0);
end;

end.