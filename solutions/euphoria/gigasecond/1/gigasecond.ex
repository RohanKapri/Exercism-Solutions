include std/datetime.e

constant GIGASECOND = 1e9

public function add_gigasecond(datetime moment)
  return datetime:add(moment, GIGASECOND, datetime:SECONDS)
end function