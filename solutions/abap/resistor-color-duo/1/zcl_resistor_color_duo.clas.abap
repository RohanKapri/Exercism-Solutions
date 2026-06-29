CLASS zcl_resistor_color_duo DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS value
      IMPORTING
        colors        TYPE string_table
      RETURNING
        VALUE(result) TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_resistor_color_duo IMPLEMENTATION.
  METHOD value.
    DATA(bands) = VALUE string_table( ( `black` ) ( `brown` ) ( `red` ) ( `orange` ) ( `yellow` ) ( `green` ) ( `blue` ) ( `violet` ) ( `grey` ) ( `white` ) ).    
    READ TABLE bands TRANSPORTING NO FIELDS WITH TABLE KEY table_line = colors[ 1 ].
    result = 10 * ( sy-tabix - 1 ).
    READ TABLE bands TRANSPORTING NO FIELDS WITH TABLE KEY table_line = colors[ 2 ].
    result = result + sy-tabix - 1.
  ENDMETHOD.
ENDCLASS.