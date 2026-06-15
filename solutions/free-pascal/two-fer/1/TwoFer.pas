unit TwoFer;

{$mode ObjFPC}{$H+}

interface

function TwoFer(const name : string) : string;

implementation

function TwoFer(const name : string) : string;
begin
  if length(name) = 0 then
  begin
    result := 'One for ' + 'you' + ', one for me.';
  end
  else
  begin
    result := 'One for ' + name + ', one for me.';
  end;
end;

end.
