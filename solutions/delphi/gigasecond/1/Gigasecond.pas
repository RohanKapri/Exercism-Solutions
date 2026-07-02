unit uGigasecond;

interface
type
  TGigasecond=Class
    public
    class function Add(date:string):string;

end;

implementation
uses System.DateUtils, System.Math, System.SysUtils;

class function TGigasecond.Add(date:string): string;
  begin
    var dt := ISO8601ToDate(date);

    var new_dt := IncSecond(dt, Trunc(Power(10,9)))  ;
    result:= FormatDateTime('yyyy-mm-dd"T"hh:nn:ss', new_dt);
  end;

end.

