* Dedicated to Shree DR.MDD
CLASS zcl_matrix DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES:
      integertab TYPE STANDARD TABLE OF i WITH EMPTY KEY .

    METHODS matrix_row
      IMPORTING
        !string       TYPE string
        !index        TYPE i
      RETURNING
        VALUE(result) TYPE integertab .
    METHODS matrix_column
      IMPORTING
        !string       TYPE string
        !index        TYPE i
      RETURNING
        VALUE(result) TYPE integertab .
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.

CLASS zcl_matrix IMPLEMENTATION.

  METHOD matrix_column.
    DATA row_idx TYPE i.
    DATA row_tab TYPE STANDARD TABLE OF string WITH EMPTY KEY.
    DATA col_tab TYPE STANDARD TABLE OF string WITH EMPTY KEY.
    DATA tmp_val TYPE i.
    SPLIT string AT '\n' INTO TABLE row_tab.
    LOOP AT row_tab INTO DATA(single_row).
      SPLIT single_row AT ` ` INTO TABLE col_tab.
      READ TABLE col_tab INTO DATA(col_val) INDEX index.
      IF sy-subrc = 0.
        tmp_val = col_val.
        INSERT tmp_val INTO TABLE result.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD matrix_row.
    DATA row_idx TYPE i.
    DATA row_tab TYPE STANDARD TABLE OF string WITH EMPTY KEY.
    DATA col_tab TYPE STANDARD TABLE OF string WITH EMPTY KEY.
    DATA tmp_val TYPE i.
    SPLIT string AT '\n' INTO TABLE row_tab.
    READ TABLE row_tab INTO DATA(single_row) INDEX index.
    IF sy-subrc = 0.
      SPLIT single_row AT ` ` INTO TABLE col_tab.
      LOOP AT col_tab INTO DATA(col_val).
        tmp_val = col_val.
        INSERT tmp_val INTO TABLE result.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
