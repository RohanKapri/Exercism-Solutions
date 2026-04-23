" Dedicated to Shree DR.MDD

CLASS zcl_etl DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    TYPES:
      BEGIN OF ty_legacy_data,
        number TYPE i,
        string TYPE string,
      END OF ty_legacy_data,
      BEGIN OF ty_new_data,
        letter TYPE c LENGTH 1,
        number TYPE i,
      END OF ty_new_data,
      tty_legacy_data TYPE SORTED TABLE OF ty_legacy_data WITH UNIQUE KEY number,
      tty_new_data    TYPE SORTED TABLE OF ty_new_data WITH UNIQUE KEY letter.

    METHODS transform IMPORTING legacy_data     TYPE tty_legacy_data
                      RETURNING VALUE(new_data) TYPE tty_new_data.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_etl IMPLEMENTATION.
  METHOD transform.
    LOOP AT legacy_data ASSIGNING FIELD-SYMBOL(<entry>).
      SPLIT to_lower( <entry>-string ) AT ',' INTO TABLE DATA(char_list).
      LOOP AT char_list ASSIGNING FIELD-SYMBOL(<ch>).
        DATA(new_row) = VALUE ty_new_data( letter = <ch> number = <entry>-number ).
        INSERT new_row INTO TABLE new_data.
      ENDLOOP.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
