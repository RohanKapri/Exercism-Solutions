unit uLeap;

interface

  function IsLeap(Year: Integer): Boolean;

implementation

function IsLeap(Year: Integer): Boolean;
begin
  if Year mod 4 = 0 then
    Result := true
  else
    Result := false
end;

end.