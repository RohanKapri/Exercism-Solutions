CLASS zcl_hamming DEFINITION PUBLIC.
  PUBLIC SECTION.
    METHODS hamming_distance
      IMPORTING
        first_strand  TYPE string
        second_strand TYPE string
      RETURNING
        VALUE(result) TYPE i
      RAISING
        cx_parameter_invalid.
ENDCLASS.
CLASS zcl_hamming IMPLEMENTATION.
  METHOD hamming_distance.
    DATA(length) = strlen( first_strand ).
    
    IF length <> strlen( second_strand ).
      RAISE EXCEPTION TYPE cx_parameter_invalid.
    ENDIF.
    DATA(offset) = 0.
    DO length TIMES.            
      IF first_strand+offset(1) <> second_strand+offset(1).
        result = result + 1.
      ENDIF.
      offset = offset + 1.
    ENDDO.
  ENDMETHOD.
ENDCLASS.