unit uReverseString;

interface
  function Reverse(Sentence:string):string;
implementation

function Reverse(Sentence:string):string;
var i:integer;
begin
  result := '';
  for i := High(Sentence) downto Low(Sentence) do
    result := result + Sentence[i];
end;

end.