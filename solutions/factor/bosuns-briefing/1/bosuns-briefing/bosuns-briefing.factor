USING: arrays bosuns-briefing.helpers kernel locals sequences ;
IN: bosuns-briefing

: roster ( names -- str )
    [ crew-line ] map
    "\n" join ;

: briefing ( names -- str )
  greeting swap roster closing 3array
  "\n" join ;





USING: kernel sequences strings ;
IN: bosuns-briefing.helpers

: greeting ( -- str )
    "All hands, attention!" ;

: crew-line ( name -- str )
    "  - " swap append ;

: closing ( -- str )
    "Carry on." ;