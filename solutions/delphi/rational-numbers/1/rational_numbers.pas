unit uRationalNumbers;

interface

type
  TFraction = record
  private
    // Values for numerator and denominator
    a:integer;
    b:integer;

    function MCD(const b1, b2:integer):integer;
    class procedure CorrectSign(var r: TFraction); static;
  public
    class function CreateFrom(const a, b:integer): TFraction; static;

    class operator Negative(const r: TFraction): TFraction;
    class operator Positive(const r: TFraction): TFraction;
    class operator Add(const r1, r2: TFraction): TFraction;
    class operator Subtract(const r1, r2: TFraction): TFraction;

    class operator Multiply(const r1, r2: TFraction): TFraction;
    class operator Divide(const r1, r2: TFraction): TFraction;

    class operator Explicit(const d: Real): TFraction;
    class operator Explicit(const r: TFraction): string;

    class operator Implicit(const i: integer): TFraction;
    class operator Implicit(const r: TFraction): Real;

    function Simplify:TFraction;
  end;
  
  
implementation

uses
  System.SysUtils;

function TFraction.MCD(const b1, b2: integer): integer;
begin
  if b2 = 0 then begin
    Result := 0
  end
  else begin
    if ((b1 mod b2)= 0) then begin
      Result := b2;
    end
    else begin
      Result := MCD(b2, b1 mod b2);
    end;
  end;
end;

class procedure TFraction.CorrectSign(var r: TFraction);
begin
  if (r.a > 0) and (r.b < 0) then begin
    r.a := r.a * -1;
    r.b := r.b * -1;
  end;
end;

class function TFraction.CreateFrom(const a, b:integer): TFraction;
begin
  Result.a := a;
  Result.b := b;
  CorrectSign(Result);
end;

class operator TFraction.Add(const r1, r2: TFraction): TFraction;
begin
  Result.a := (r1.a * r2.b) + (r2.a * r1.b);
  Result.b := r1.b * r2.b;
  Result := Result.Simplify;
end;

class operator TFraction.Subtract(const r1, r2: TFraction): TFraction;
begin
  Result.a := (r1.a * r2.b) - (r2.a * r1.b);
  Result.b := r1.b * r2.b;
  Result := Result.Simplify;
end;

class operator TFraction.Divide(const r1, r2: TFraction): TFraction;
begin
  Result := TFraction.CreateFrom((r1.a * r2.b), (r2.a * r1.b)).Simplify;
end;

class operator TFraction.Multiply(const r1, r2: TFraction): TFraction;
begin
  Result := TFraction.CreateFrom((r1.a * r2.a), (r1.b * r2.b)).Simplify;
end;

class operator TFraction.Explicit(const d: Real): TFraction;
begin
  if d = 0 then
    Result := TFraction.CreateFrom(0, 1)
  else
    Result := TFraction.CreateFrom(Trunc(d * (1/d)), Trunc(1/d)).Simplify;
end;

class operator TFraction.Explicit(const r: TFraction): string;
begin
  Result := r.a.ToString + '/' + r.b.ToString;
end;

class operator TFraction.Implicit(const i: integer): TFraction;
begin
  Result := TFraction.CreateFrom(i, 1);
end;

class operator TFraction.Implicit(const r: TFraction): Real;
begin
  Result := r.a / r.b;
end;

class operator TFraction.Negative(const r: TFraction): TFraction;
begin
  Result := TFraction.CreateFrom((r.a * -1), r.b);
end;

class operator TFraction.Positive(const r: TFraction): TFraction;
begin
  Result := r;
end;

function TFraction.Simplify: TFraction;
var
  i:integer;
begin
  i := MCD(a, b);
  if (i = 0) then
    Result := TFraction.CreateFrom(0, 1)
  else begin
    Result := TFraction.CreateFrom((a div i), (b div i));
  end;
end;

end.