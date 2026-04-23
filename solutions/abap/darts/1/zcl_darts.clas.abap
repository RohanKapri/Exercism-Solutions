* Dedicated to Shree DR.MDD
CLASS zcl_darts DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS score
      IMPORTING
        x TYPE f
        y TYPE f
      RETURNING
        VALUE(result) TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.

CLASS zcl_darts IMPLEMENTATION.
  METHOD score.
    DATA(radius) = sqrt( x * x + y * y ).
    IF 0 <= radius AND radius <= 1.
      result = 10.
    ELSEIF 1 < radius AND radius <= 5.
      result = 5.
    ELSEIF 5 < radius AND radius <= 10.
      result = 1.
    ELSE.
      result = 0.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
