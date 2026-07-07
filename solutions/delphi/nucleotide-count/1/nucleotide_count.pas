unit uNucleotideCount;

interface

uses
  System.Sysutils, System.Generics.Collections;

type
  EInvalidNucleotideException = class(Exception);

  TDNA = class
  const
    ADN_TYPES = ['A', 'T', 'C', 'G'];
  private
    FADNString: string;
    NucleotidesDicc:TDictionary<Char, Integer>;
    procedure InitDictionaryResult;
    procedure TestCorrectADNString;
  public
    function NucleotideCounts:TDictionary<Char, Integer>;
    constructor Create(const ADNString:string);
    destructor destroy; reintroduce;
    property ADNString:string read FADNString;
  end;

implementation

{ TDNA }

constructor TDNA.Create(const ADNString: string);
begin
  inherited Create;
  FADNString := ADNString;
  TestCorrectADNString;      // Test for ecepotions
  NucleotidesDicc := TDictionary<Char, Integer>.Create;
  // Fill the initial values of Dicc.
  InitDictionaryResult;
end;

destructor TDNA.destroy;
begin
  FreeAndNil(NucleotidesDicc);
  inherited;
end;

procedure TDNA.InitDictionaryResult;
begin
  NucleotidesDicc := TDictionary<char, integer>.Create;
  NucleotidesDicc.Add('A',0);
  NucleotidesDicc.Add('T',0);
  NucleotidesDicc.Add('C',0);
  NucleotidesDicc.Add('G',0);
end;

function TDNA.NucleotideCounts: TDictionary<Char, Integer>;
var
  i:integer;
  key:Char;
begin
  Result := NucleotidesDicc;
  for i := Low(FADNString) to High(FADNString) do begin
    key := FADNString[i];
    NucleotidesDicc.Items[key] := (Result.Items[key] + 1);
  end;
end;

procedure TDNA.TestCorrectADNString;
var
  i:Integer;
begin
  for i := Low(FADNString) to High(FADNString) do
    if not CharInSet(FADNString[i], ADN_TYPES) then
      raise EInvalidNucleotideException.Create('Invalid nucleotide in strand');
end;

end.