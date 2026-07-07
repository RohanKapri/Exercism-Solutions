unit uAllergies;

interface

uses
  System.Generics.Collections;

type
  TAllergiesList = TList<string>;

  IAllergies = interface
    ['{CA62F112-E85E-419A-BC00-07FBB2309CAA}']
    function AllergicTo(const Allergies:string):boolean;
    function List:TAllergiesList;
  end;

  TAllergieValue = record
    Value:Integer;
    Name:string;
  end;

  TAllergies = class(TInterfacedObject, IAllergies)
  const
    ALERGIES_DICC:Array[0..7] of string = ('eggs','peanuts', 'shellfish', 'strawberries', 'tomatoes', 'chocolate', 'pollen', 'cats');
  private
    FAllergiesList:TAllergiesList;
    procedure PopulateAllergieList(const Allergies:integer);
  public
    function AllergicTo(const Allergie:string):boolean;
    function List:TAllergiesList;
    constructor Create(const Allergies:integer);
    destructor Destroy; override;
  end;


implementation

uses
  System.SysUtils;

function IntToBin(Value: integer): string;
begin
  Result := string.Empty;
  while (Value > 0) do begin
    Result := Chr(Ord('0') + (Value MOD 2)) + Result;
    Value := Value shr 1;
  end;
end;

{ TAllergies }

function TAllergies.AllergicTo(const Allergie: string): boolean;
begin
  Result := FAllergiesList.Contains(Allergie);
end;

function TAllergies.List: TAllergiesList;
begin
  Result := FAllergiesList;
end;

// populate the list of allergies
procedure TAllergies.PopulateAllergieList(const Allergies:integer);
var
  s:string;
  i, index:Integer;
begin
  s := IntToBin(Allergies);
  for i := Length(s) downto 1 do
    if (s[i] = '1') then begin
      index := Length(s) - i;
      if (index < Length(ALERGIES_DICC)) then
        FAllergiesList.Add(ALERGIES_DICC[index]);
    end;
end;

constructor TAllergies.Create(const Allergies:integer);
begin
  inherited Create;
  FAllergiesList := TAllergiesList.Create;
  // Get Allergie list
  PopulateAllergieList(Allergies);
end;

destructor TAllergies.Destroy;
begin
  FreeAndNil(FAllergiesList);
end;

end.