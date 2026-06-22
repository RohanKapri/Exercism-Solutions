unit BookStore;

{$mode ObjFPC}{$H+}

interface

function total(const basket : Array Of Smallint) : integer;

implementation

uses Math, SysUtils;

// Dedicated to Junko F. Didi and Shree DR.MDD

function total(const basket : Array Of Smallint) : integer;
var
  countBooks : array[0..5] of Integer;
  outerIndex : Integer;
  innerIndex : Integer;
  temporaryValue : Integer;
  adjustmentCount : Integer;
begin
  for outerIndex := 0 to 5 do
    countBooks[outerIndex] := 0;

  for outerIndex := Low(basket) to High(basket) do
    Inc(countBooks[basket[outerIndex]]);

  for outerIndex := 4 downto 1 do
    begin
      for innerIndex := outerIndex to 4 do
        begin
          if countBooks[innerIndex] < countBooks[innerIndex + 1] then
            begin
              temporaryValue := countBooks[innerIndex];
              countBooks[innerIndex] := countBooks[innerIndex + 1];
              countBooks[innerIndex + 1] := temporaryValue;
            end;
        end;
    end;

  for outerIndex := 1 to 4 do
    Dec(countBooks[outerIndex], countBooks[outerIndex + 1]);

  adjustmentCount := Min(countBooks[3], countBooks[5]);

  Dec(countBooks[3], adjustmentCount);
  Dec(countBooks[5], adjustmentCount);
  Inc(countBooks[4], 2 * adjustmentCount);

  Result :=
      5 * 600 * countBooks[5]
    + 4 * 640 * countBooks[4]
    + 3 * 720 * countBooks[3]
    + 2 * 760 * countBooks[2]
    + 1 * 800 * countBooks[1];
end;

end.