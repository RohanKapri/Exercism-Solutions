* Dedicated to Shree DR.MDD
CLASS zcl_phone_number DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS clean
      IMPORTING
        !number       TYPE string
      RETURNING
        VALUE(result) TYPE string
      RAISING
        cx_parameter_invalid.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_phone_number IMPLEMENTATION.

  METHOD clean.
    DATA code1 TYPE string.
    DATA code2 TYPE string.
    DATA code3 TYPE string.
    DATA code4 TYPE string.
    DATA exc   TYPE REF TO cx_parameter_invalid.

    " extract digits according to North American rules
    FIND REGEX '1*.*?([2-9]\d\d).*?([2-9]\d\d).*?(\d\d\d\d).*?(\d)*'
         IN number
         SUBMATCHES code1 code2 code3 code4.

    IF sy-subrc = 0 AND strlen( code4 ) = 0.
      result = code1 && code2 && code3.
    ELSE.
      exc = NEW cx_parameter_invalid( ).
      RAISE EXCEPTION exc.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
