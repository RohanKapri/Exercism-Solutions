unit uRnaTranscription;

interface

uses System.StrUtils, System.SysUtils;

type
  complement = class
    class function OfDna(ARna: string): string;
  end;
implementation

{ complement }

class function complement.OfDna(ARna: string): string;
begin
  for var i := 1 to ARna.Length do
    case ARna[i] of
      'G': Result := Result + 'C';
      'C': Result := Result + 'G';
      'T': Result := Result + 'A';
      'A': Result := Result + 'U';
    else
      Result := '';
    end;

end;

end.