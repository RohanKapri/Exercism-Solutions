unit uProteinTranslation;

interface

uses
  System.Generics.Collections;

type
  TCodon = string;
  TProtein = string;
  TCodonsProteins = TDictionary<TProtein, TCodon>;

  TProteinTranslation = class
    class procedure Get3Element(RNA:string; var Element:TCodon; var Result:string);
    class function InitializeCodonsProteinsDicc:TCodonsProteins;
    class function Proteins(RNA:string):TArray<TProtein>;
 end;

implementation

uses
  System.Sysutils;

{ TProteinTranslation }

class function TProteinTranslation.InitializeCodonsProteinsDicc: TCodonsProteins;
begin
  Result := TDictionary<TProtein, TCodon>.Create;
  Result.Add('AUG', 'Methionine');
  Result.Add('UUU', 'Phenylalanine');
  Result.Add('UUC', 'Phenylalanine');
  Result.Add('UUA', 'Leucine');
  Result.Add('UUG', 'Leucine');
  Result.Add('UCU', 'Serine');
  Result.Add('UCC', 'Serine');
  Result.Add('UCA', 'Serine');
  Result.Add('UCG', 'Serine');
  Result.Add('UAU', 'Tyrosine');
  Result.Add('UAC', 'Tyrosine');
  Result.Add('UGU', 'Cysteine');
  Result.Add('UGC', 'Cysteine');
  Result.Add('UGG', 'Tryptophan');
  Result.Add('UAA', 'STOP');
  Result.Add('UAG', 'STOP');
  Result.Add('UGA', 'STOP');
end;

// Extract one codon from RNA
class procedure TProteinTranslation.Get3Element(RNA:string; var Element:string; var Result:string);
begin
  Element := string.Empty;
  if Length(RNA) < 3 then
    Exit;
  Element := Copy(RNA, 1, 3);
  Result := Copy(RNA, 4, Length(RNA));
end;

class function TProteinTranslation.Proteins(RNA: string): TArray<TProtein>;
var
  l:TList<TProtein>;
  cp:TCodonsProteins;
  Elem, Res:string;
begin
  Result := [];
  l := TList<string>.Create;
  try
    // initialize dictionary
    cp := TProteinTranslation.InitializeCodonsProteinsDicc;
    // Extract one codon
    TProteinTranslation.Get3Element(RNA, Elem, Res);
    while (Elem <> string.Empty) and (cp.Items[Elem] <> 'STOP') do begin
      l.Add(cp.Items[Elem]);
      // Extract next codon
      TProteinTranslation.Get3Element(Res, Elem, Res);
    end;
    Result := l.ToArray;    // array of TProtein
  finally
    FreeAndNil(l);
  end;
end;

end.