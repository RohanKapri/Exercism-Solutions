unit Triangle;

{$mode ObjFPC}{$H+}

interface

function equilateral(const a, b, c : double): boolean;
function   isosceles(const a, b, c : double): boolean;
function     scalene(const a, b, c : double): boolean;

implementation

function valid(const a, b, c : double): boolean;
begin
  result := (a > 0) and (b > 0) and (c > 0) and (a <= b + c) and (b <= c + a) and (c <= a + b);
end;

function equilateral(const a, b, c : double): boolean;
begin
  result := valid(a, b, c) and ((a = b) and (b = c) and (c = a));
end;

function isosceles(const a, b, c : double): boolean;
begin
  result := valid(a, b, c) and ((a = b) or (b = c) or (c = a));
end;

function scalene(const a, b, c : double): boolean;
begin
  result := valid(a, b, c) and ((a <> b) and (b <> c) and (c <> a));
end;

end.