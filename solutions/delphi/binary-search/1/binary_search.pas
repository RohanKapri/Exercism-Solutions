unit uBinarySearch;

interface

type
  TBinarySearch = record
    function Search(ls: TArray<integer>; ans: integer): integer;
  end;

var
  BinarySearch: TBinarySearch;

implementation

{ TBinarySearch }

function TBinarySearch.Search(ls: TArray<integer>; ans: integer): integer;
var
  left, right: integer;
begin
  left := 0;
  right := Length(ls) - 1;
  result := right div 2;
  if right = -1 then
    Exit(-1);
  while right <> left do
  begin
    if ls[result] = ans then
      break
    else if ls[result] < ans then
      left := result + 1
    else
      right := result;
    result := (left + right) div 2;
  end;
  if ls[result] <> ans then
    result := -1;
end;

end.