CLASS zcl_leap DEFINITION PUBLIC.
  PUBLIC SECTION.
    METHODS leap
      IMPORTING
        year          TYPE i
      RETURNING
        VALUE(result) TYPE abap_bool.
ENDCLASS.
CLASS zcl_leap IMPLEMENTATION.
  METHOD leap.
    result = abap_false.
    if year mod 4 = 0.
      result = abap_true.
      if year mod 100 = 0.
        result = abap_false.
        if year mod 400 = 0.
          result = abap_true.
        endif.
      endif.
    endif.
  ENDMETHOD.

ENDCLASS.