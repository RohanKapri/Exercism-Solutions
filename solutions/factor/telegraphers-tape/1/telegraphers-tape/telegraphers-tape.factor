USING: accessors destructors io kernel locals ;
IN: telegraphers-tape
TUPLE: tape < disposable wire ;
: <tape> ( wire -- tape )
  tape new-disposable swap >>wire ;
INSTANCE: tape input-stream
:: until-dot-dash-space ( stream -- elt )
  t :> elt!
  [
    elt 46 =
    elt 45 =
    elt 32 =
    elt f =
    or or or
  ]
  [
    stream stream-read1 elt!
  ]
  until
  elt ;
M: tape stream-read1
  wire>> until-dot-dash-space ;

M: tape stream-element-type
  wire>> stream-element-type ;

M: tape dispose*
  wire>> dispose ;