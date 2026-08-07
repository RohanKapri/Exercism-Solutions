CLASS zcl_pangram DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS is_pangram
      IMPORTING
        VALUE(sentence) TYPE string
      RETURNING
        VALUE(result) TYPE abap_bool.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_pangram IMPLEMENTATION.
  METHOD is_pangram.
    result = matches( 
      val  = sentence
      case = abap_false
      pcre = '^(?=.*[aA])(?=.*[bB])(?=.*[cC])(?=.*[dD])(?=.*[eE])(?=.*[fF])(?=.*[gG])(?=.*[hH])(?=.*[iI])(?=.*[jJ])(?=.*[kK])(?=.*[lL])(?=.*[mM])(?=.*[nN])(?=.*[oO])(?=.*[pP])(?=.*[qQ])(?=.*[rR])(?=.*[sS])(?=.*[tT])(?=.*[uU])(?=.*[vV])(?=.*[wW])(?=.*[xX])(?=.*[yY])(?=.*[zZ]).*$' 
    ).
  ENDMETHOD.


ENDCLASS.