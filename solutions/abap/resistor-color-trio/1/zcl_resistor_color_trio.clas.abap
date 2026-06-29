CLASS zcl_resistor_color_trio DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS label
      IMPORTING
        colors       TYPE string_table
      RETURNING
        VALUE(result) TYPE string.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.

CLASS zcl_resistor_color_trio IMPLEMENTATION.
  METHOD label.
    DATA(bands) = VALUE string_table( ( `black` ) ( `brown` ) ( `red` ) ( `orange` ) ( `yellow` ) ( `green` ) ( `blue` ) ( `violet` ) ( `grey` ) ( `white` ) ).    
    READ TABLE bands TRANSPORTING NO FIELDS WITH TABLE KEY table_line = colors[ 1 ].
    DATA(val) = 10 * ( sy-tabix - 1 ).
    READ TABLE bands TRANSPORTING NO FIELDS WITH TABLE KEY table_line = colors[ 2 ].
    val = val + sy-tabix - 1.
    READ TABLE bands TRANSPORTING NO FIELDS WITH TABLE KEY table_line = colors[ 3 ].
    result = |{ val * ( 10 ** ( sy-tabix - 1 ) ) } ohms|.
    result = replace( val = result sub = `000000000 ` with = ` giga` ).
    result = replace( val = result sub = `000000 ` with = ` mega` ).
    result = replace( val = result sub = `000 ` with = ` kilo` ).
  ENDMETHOD.
ENDCLASS.