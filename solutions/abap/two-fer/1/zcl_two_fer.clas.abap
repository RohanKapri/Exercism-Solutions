CLASS zcl_two_fer DEFINITION PUBLIC.
  PUBLIC SECTION.
    METHODS two_fer
      IMPORTING
        input         TYPE string OPTIONAL
      RETURNING
        VALUE(result) TYPE string.
ENDCLASS.

CLASS zcl_two_fer IMPLEMENTATION.

  METHOD two_fer.
    if input = ''.
      data(name) = `you`.
    else.
      name = input.
    endif.
    result = |One for { name }, one for me.|.
  ENDMETHOD.
 
ENDCLASS.