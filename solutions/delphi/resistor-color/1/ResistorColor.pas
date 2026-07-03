unit uResistorColor;

interface

uses
  System.SysUtils;

type
  ENotCorrectColor = class(exception);

  TResistor = class
  public
    /// <summary> Return the code associated to a color </summary>
    class function colorCode(const AColorName:string):Integer;
    /// <summary> Return the array of colors </summary>
    class function Colors:TArray<string>;
  end;

const
  /// <summary> Array of colors </summary>
  ARRAY_COLORS: TArray<string> = ['black', 'brown', 'red', 'orange', 'yellow', 'green', 'blue', 'violet', 'grey', 'white'];

implementation

uses
  System.StrUtils;


class function TResistor.colorCode(const AColorName: string): Integer;
begin
  Result := IndexStr(AColorName, TResistor.Colors);
  if (Result = -1) then
    raise ENotCorrectColor.Create('The color is incorrect.');
end;

class function TResistor.Colors: TArray<string>;
begin
  Result := ARRAY_COLORS;
end;

end.