* Dedicated to Shree DR.MDD
CLASS zcl_beer_song DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    METHODS recite
      IMPORTING
        !initial_bottles_count TYPE i
        !take_down_count       TYPE i
      RETURNING
        VALUE(result)          TYPE string_table.

  PROTECTED SECTION.
  PRIVATE SECTION.

    METHODS bottles
      IMPORTING
        !count        TYPE i
        !prefix       TYPE c DEFAULT 'n'
        !wall         TYPE c DEFAULT 'y'
      RETURNING
        VALUE(result) TYPE string.
ENDCLASS.

CLASS zcl_beer_song IMPLEMENTATION.

  METHOD bottles.
    DATA(bottle_word) = |bottle{ COND #( WHEN count <> 1 THEN `s` ) } of beer|.
    DATA(number_part) = COND #( WHEN count = 0 THEN |{ prefix }o more| ELSE |{ count }| ).
    DATA(wall_part)   = COND #( WHEN wall = 'y' THEN ' on the wall' ELSE '' ).
    result = |{ number_part } { bottle_word }{ wall_part }|.
  ENDMETHOD.

  METHOD recite.

    DATA(first_line)  = |{ bottles( count = initial_bottles_count prefix = 'N' ) },| &&
                         | { bottles( count = initial_bottles_count wall = 'N' ) }.|.
    INSERT first_line INTO TABLE result.

    IF initial_bottles_count = 0.
      DATA(store_line) = |Go to the store and buy some more, { bottles( 99 ) }.|.
      INSERT store_line INTO TABLE result.
    ELSE.
      DATA(take_line) = |Take { COND #( WHEN initial_bottles_count = 1 THEN `it` ELSE `one` ) } down and pass it around,| &&
                         | { bottles( initial_bottles_count - 1 ) }.|.
      INSERT take_line INTO TABLE result.
    ENDIF.

    IF take_down_count > 1.
      INSERT || INTO TABLE result.
      DATA(next_lines) = recite(
        initial_bottles_count = initial_bottles_count - 1
        take_down_count       = take_down_count - 1 ).
      INSERT LINES OF next_lines INTO TABLE result.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
