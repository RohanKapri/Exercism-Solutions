unit UTriangle;

interface

type
  TTriangleType = (Equilateral, Isosceles, Scalene);

  Triangle = class
  private
    class function DetectInequalityViolation(const ASide1, ASide2, ASide3: extended):Boolean;
  public
    class function Sides(const AType:TTriangleType; const ASide1, ASide2, ASide3: extended): Boolean;
  end;
  
  
implementation

uses
  System.SysUtils;

{ TTriangle }

class function Triangle.DetectInequalityViolation(const ASide1, ASide2, ASide3: extended): Boolean;
begin
  Result := (ASide1 + ASide2 < ASide3) or
            (ASide1 + ASide3 < ASide2) or
            (ASide2 + ASide3 < ASide1);
end;

class function Triangle.Sides(const AType: TTriangleType; const ASide1, ASide2, ASide3: extended): Boolean;
begin
  Result := False;

  if DetectInequalityViolation(ASide1, ASide2, ASide3) then
    Exit;           // EnequalityViolation
  if (ASide1 + ASide2 + ASide3 = 0) then
    Exit;           // Is not a triangle

  if (ASide1 <> ASide2) and (ASide1 <> ASide3) and (ASide2 <> ASide3) then
    Result := (AType = Scalene);
  if ((ASide1 = ASide2)  or (ASide1 = ASide3) or (ASide2 = ASide3)) then
    Result := (AType = Isosceles);
  if (ASide1 = ASide2) and (ASide1 = ASide3) then
    Result := (AType = Equilateral) or (AType = Isosceles);

end;

end.