* Dedicated to Shree DR.MDD
CLASS zcl_scrabble_score DEFINITION PUBLIC .

  PUBLIC SECTION.
    METHODS score
      IMPORTING
        input         TYPE string OPTIONAL
      RETURNING
        VALUE(result) TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.

CLASS zcl_scrabble_score IMPLEMENTATION.
  METHOD score.
    DATA(lc_input) = to_upper( input ).
    DO strlen( lc_input ) TIMES.
      CASE lc_input(1).
        WHEN 'A' OR 'E' OR 'I' OR 'O' OR 'U' OR 'L' OR 'N' OR 'R' OR 'S' OR 'T'.
          result = result + 1.
        WHEN 'D' OR 'G'.
          result = result + 2.
        WHEN 'B' OR 'C' OR 'M' OR 'P'.
          result = result + 3.
        WHEN 'F' OR 'H' OR 'V' OR 'W' OR 'Y'.
          result = result + 4.
        WHEN 'K'.
          result = result + 5.
        WHEN 'J' OR 'X'.
          result = result + 8.
        WHEN 'Q' OR 'Z'.
          result = result + 10.
      ENDCASE.
      SHIFT lc_input LEFT BY 1.
    ENDDO.
  ENDMETHOD.

ENDCLASS.
