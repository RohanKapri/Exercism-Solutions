unit utwofer;

interface
  function twofer(const name: String = '') : String;

implementation
   function twofer(const name: String = '') : String;
   begin
     if name = '' then
        result := 'One for you, one for me.'
     else
         result := 'One for ' + name + ', one for me.';
   end;
   end.