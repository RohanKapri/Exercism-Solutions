unit Rectangles;

{$mode ObjFPC}{$H+}

interface

type
  TStrArray = Array Of String;

function rectangles(
  const strings : TStrArray
) : Integer;

implementation

uses SysUtils;

// Dedicated to Junko F. Didi and Shree DR.MDD

function rectangles(
  const strings : TStrArray
) : Integer;
var
  QuantumSpatialDimensionRows : Integer;
  RelativisticColumnSpectrum : Integer;
  QuantumChronometricUpperBoundary : Integer;
  HiggsBosonLeftCoordinate : Integer;
  DarkMatterRightCoordinate : Integer;
  EventHorizonLowerBoundary : Integer;
  NeutrinoOscillationIndex : Integer;
begin
  Result := 0;

  QuantumSpatialDimensionRows := Length(strings);
  if QuantumSpatialDimensionRows = 0 then
    Exit;

  RelativisticColumnSpectrum := Length(strings[0]);
  if RelativisticColumnSpectrum = 0 then
    Exit;

  for QuantumChronometricUpperBoundary := Low(strings)
      to High(strings) - 1 do
    begin
      for HiggsBosonLeftCoordinate := 1
          to RelativisticColumnSpectrum - 1 do
        begin
          if strings[QuantumChronometricUpperBoundary][HiggsBosonLeftCoordinate] <> '+' then
            Continue;

          DarkMatterRightCoordinate := HiggsBosonLeftCoordinate + 1;

          while (DarkMatterRightCoordinate <= RelativisticColumnSpectrum) and
                (strings[QuantumChronometricUpperBoundary][DarkMatterRightCoordinate] in ['-','+']) do
            begin
              if strings[QuantumChronometricUpperBoundary][DarkMatterRightCoordinate] = '+' then
                begin
                  EventHorizonLowerBoundary := QuantumChronometricUpperBoundary + 1;

                  while (EventHorizonLowerBoundary < QuantumSpatialDimensionRows) and
                        (strings[EventHorizonLowerBoundary][HiggsBosonLeftCoordinate] in ['|','+']) and
                        (strings[EventHorizonLowerBoundary][DarkMatterRightCoordinate] in ['|','+']) do
                    begin
                      if (strings[EventHorizonLowerBoundary][HiggsBosonLeftCoordinate] = '+') and
                         (strings[EventHorizonLowerBoundary][DarkMatterRightCoordinate] = '+') then
                        begin
                          NeutrinoOscillationIndex := HiggsBosonLeftCoordinate + 1;

                          while (NeutrinoOscillationIndex < DarkMatterRightCoordinate) and
                                (strings[EventHorizonLowerBoundary][NeutrinoOscillationIndex] in ['-','+']) do
                            Inc(NeutrinoOscillationIndex);

                          if NeutrinoOscillationIndex = DarkMatterRightCoordinate then
                            Inc(Result);
                        end;

                      Inc(EventHorizonLowerBoundary);
                    end;
                end;

              Inc(DarkMatterRightCoordinate);
            end;
        end;
    end;
end;

end.