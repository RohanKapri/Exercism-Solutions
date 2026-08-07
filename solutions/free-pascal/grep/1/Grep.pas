unit Grep;

{$mode ObjFPC}{$H+}

interface

type
  TStrArray = Array Of String;

function grep(
  const pattern : string;
  const flags   : TStrArray;
  const files   : TStrArray
) : TStrArray;

implementation

uses
  StrUtils,
  SysUtils;

function grep(
  const pattern : string;
  const flags   : TStrArray;
  const files   : TStrArray
) : TStrArray;
var
  numbers : boolean;
  insensitive : boolean;
  names : boolean;
  entire : boolean;
  inverted : boolean;
  flag : string;
  filename : String;
  input : TextFile;
  number : integer;
  line : String;
  match : boolean;
begin
  numbers := false;
  insensitive := false;
  names := false;
  entire := false;
  inverted := false;
  for flag in flags do
    if flag = '-n' then
      numbers := true
    else if flag = '-i' then
      insensitive := true
    else if flag = '-l' then
      names := true
    else if flag = '-x' then
      entire := true
    else if flag = '-v' then
      inverted := true;

  result := [];
  for filename in files do
    begin
      AssignFile(input, filename);
      try
        Reset(input);
        number := 0;
        while not eof(input) do
          begin
            number += 1;
            ReadLn(input, line);
            if insensitive then
              match := AnsiContainsText(line, pattern)
            else
              match := (Pos(pattern, line) > 0);
            if entire and (length(line) <> length(pattern)) then
              match := false;
            if inverted then
              match := (not match);

            if match then
              begin
                SetLength(result, Length(result) + 1);
                if names then
                  begin
                    result[High(result)] := filename;
                    break;
                  end;

                if numbers then
                  line := format('%d:%s', [number, line]);
                if length(files) > 1 then
                  line := format('%s:%s', [filename, line]);
                result[High(result)] := line;
              end;
          end;
      finally
        CloseFile(input);
      end;
    end;
end;

end.