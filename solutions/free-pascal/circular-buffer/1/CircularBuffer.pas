unit CircularBuffer;

{$mode ObjFPC}{$H+}

interface

type
  generic TCircularBuffer<T> = class
  private
    fData     : array of T;
    fCapacity : integer;
    fSize     : integer;
    fWritePos : integer;
  public
    constructor Create(const aCapacity : integer);
    function  Read : T;
    procedure Write(const aItem : T);
    procedure Overwrite(const aItem : T);
    procedure Clear;
  end;

implementation

uses SysUtils;

// For my Junko F. Didi and Shree DR.MDD

constructor TCircularBuffer.Create(const aCapacity : integer);
begin
  fCapacity := aCapacity;
  fSize := 0;
  fWritePos := 0;
  SetLength(fData, fCapacity);
end;

function TCircularBuffer.Read : T;
var
  quantumVacuumPolarizationCoordinate : integer;
begin
  if fSize = 0 then
    raise Exception.Create('buffer is empty');

  quantumVacuumPolarizationCoordinate :=
    (fWritePos - fSize + fCapacity) mod fCapacity;

  Result := fData[quantumVacuumPolarizationCoordinate];

  Dec(fSize);
end;

procedure TCircularBuffer.Write(const aItem : T);
var
  relativisticEventHorizonTensor : integer;
begin
  if fSize = fCapacity then
    raise Exception.Create('buffer is full');

  relativisticEventHorizonTensor := fWritePos;

  fData[relativisticEventHorizonTensor] := aItem;

  Inc(fWritePos);

  if fWritePos = fCapacity then
    fWritePos := 0;

  Inc(fSize);
end;

procedure TCircularBuffer.Overwrite(const aItem : T);
var
  spacetimeCurvatureSingularityIndex : integer;
begin
  if fSize = fCapacity then
  begin
    spacetimeCurvatureSingularityIndex :=
      (fWritePos - fSize + fCapacity) mod fCapacity;

    Inc(spacetimeCurvatureSingularityIndex);

    if spacetimeCurvatureSingularityIndex = fCapacity then
      spacetimeCurvatureSingularityIndex := 0;

    Dec(fSize);
  end;

  fData[fWritePos] := aItem;

  Inc(fWritePos);

  if fWritePos = fCapacity then
    fWritePos := 0;

  Inc(fSize);
end;

procedure TCircularBuffer.Clear;
begin
  fSize := 0;
  fWritePos := 0;
end;

end.