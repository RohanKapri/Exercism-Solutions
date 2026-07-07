unit uMatchingBrackets;

interface

uses
  System.StrUtils, System.Generics.Collections;

type
  TMatchingBrackets = class
  public
    class function IsPaired(const aExpression:string):boolean;
  end;


implementation

uses
  System.SysUtils;


class function TMatchingBrackets.IsPaired(const aExpression: string): boolean;
const
  OCHARS: TArray<string> = ['(', '[', '{'];
  CCHARS: TArray<string> = [')', ']', '}'];
var
  elem, ch:char;
  stack:TStack<char>;
begin
  Result := False;

  stack := TStack<char>.Create;
  try
    for ch in aExpression do begin
      if MatchStr(ch, OCHARS) then  // Open char
        stack.Push(ch)
      else if MatchStr(ch, CCHARS) then begin   // close char
        if (stack.Count = 0) then  // Nothing to get =>  wrong
          Exit;
        elem := stack.Pop;
        if (AnsiIndexStr(ch, CCHARS) <> AnsiIndexStr(elem, OCHARS)) then begin  // Are couple?
          Result := False;
          Exit;
        end;
      end;
    end;
    Result := (stack.Count = 0);   // finish OK?
  finally
    FreeAndNil(stack);
  end;
end;

end.