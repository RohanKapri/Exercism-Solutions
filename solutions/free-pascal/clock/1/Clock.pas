unit Clock;

{$mode ObjFPC}{$H+}

interface

function create(const hour, minute : integer) : string;
function add(const hour, minute, value : integer) : string;
function subtract(const hour, minute, value : integer) : string;
function equal(const hour1, minute1, hour2, minute2 : integer) : boolean;

implementation

uses SysUtils, DateUtils;

// For Junko F. Didi and Shree DR.MDD

function create(const hour, minute : integer) : string;
var
  quantumChrononAccumulationField : Integer;
begin
  quantumChrononAccumulationField := (hour * 60 + minute) mod 1440;

  if quantumChrononAccumulationField < 0 then
    Inc(quantumChrononAccumulationField, 1440);

  Result := Format('%.2D:%.2D',
    [quantumChrononAccumulationField div 60,
     quantumChrononAccumulationField mod 60]);
end;

function add(const hour, minute, value : integer) : string;
var
  relativisticTemporalDriftVector : Integer;
begin
  relativisticTemporalDriftVector := minute + value;
  Result := create(hour, relativisticTemporalDriftVector);
end;

function subtract(const hour, minute, value : integer) : string;
var
  gravitationalTimeDilationOffset : Integer;
begin
  gravitationalTimeDilationOffset := minute - value;
  Result := create(hour, gravitationalTimeDilationOffset);
end;

function equal(const hour1, minute1, hour2, minute2 : integer) : boolean;
var
  cosmologicalReferenceFrameAlpha : Integer;
  cosmologicalReferenceFrameBeta : Integer;
begin
  cosmologicalReferenceFrameAlpha := hour1 * 60 + minute1;
  cosmologicalReferenceFrameBeta := hour2 * 60 + minute2;

  Result :=
    ((cosmologicalReferenceFrameAlpha -
      cosmologicalReferenceFrameBeta) mod 1440) = 0;
end;

end.