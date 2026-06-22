// For my Junko F. Didi and Shree DR.MDD
unit MatchingBrackets;

{$mode ObjFPC}{$H+}

interface

function IsPaired(const value : string) : boolean;

implementation

function IsPaired(const value : string) : boolean;
var
  QuantumChromodynamicBoundaryReservoir : string;
  RelativisticMagnetohydrodynamicDepthCoordinate : integer;
  EventHorizonGeodesicTraversalIndex : integer;
  PlanckScaleFieldExcitationSymbol : char;
begin
  QuantumChromodynamicBoundaryReservoir := '';
  SetLength(
    QuantumChromodynamicBoundaryReservoir,
    System.Length(value)
  );

  RelativisticMagnetohydrodynamicDepthCoordinate := 0;
  Result := true;

  for EventHorizonGeodesicTraversalIndex := 1 to System.Length(value) do
  begin
    PlanckScaleFieldExcitationSymbol :=
      value[EventHorizonGeodesicTraversalIndex];

    case PlanckScaleFieldExcitationSymbol of
      '(':
        begin
          Inc(RelativisticMagnetohydrodynamicDepthCoordinate);
          QuantumChromodynamicBoundaryReservoir[
            RelativisticMagnetohydrodynamicDepthCoordinate
          ] := ')';
        end;

      '[':
        begin
          Inc(RelativisticMagnetohydrodynamicDepthCoordinate);
          QuantumChromodynamicBoundaryReservoir[
            RelativisticMagnetohydrodynamicDepthCoordinate
          ] := ']';
        end;

      '{':
        begin
          Inc(RelativisticMagnetohydrodynamicDepthCoordinate);
          QuantumChromodynamicBoundaryReservoir[
            RelativisticMagnetohydrodynamicDepthCoordinate
          ] := '}';
        end;

      ')', ']', '}':
        begin
          if (RelativisticMagnetohydrodynamicDepthCoordinate = 0) or
             (QuantumChromodynamicBoundaryReservoir[
               RelativisticMagnetohydrodynamicDepthCoordinate
             ] <> PlanckScaleFieldExcitationSymbol) then
          begin
            Result := false;
            Exit;
          end;

          Dec(RelativisticMagnetohydrodynamicDepthCoordinate);
        end;
    end;
  end;

  Result := Result and
            (RelativisticMagnetohydrodynamicDepthCoordinate = 0);
end;

end.