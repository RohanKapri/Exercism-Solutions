CLASS zcl_binary_search DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    TYPES integertab TYPE STANDARD TABLE OF i WITH EMPTY KEY.
    METHODS binary_search
      IMPORTING
        val           TYPE i
        table         TYPE integertab
      RETURNING
        VALUE(result) TYPE i
      RAISING
        cx_sy_itab_line_not_found.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_binary_search IMPLEMENTATION.

  METHOD binary_search.
    " Miramos en la tabla si hay algun valor como el pasado por parámetro
    READ TABLE table WITH KEY table_line = val BINARY SEARCH TRANSPORTING NO FIELDS.
    
    " Si no hay error, cogemos el indice del array
    " Si hay error, lanzamos excepción
    IF sy-subrc IS INITIAL.
      result = sy-tabix.
    ELSE.
      RAISE EXCEPTION TYPE cx_sy_itab_line_not_found.
    ENDIF.
  ENDMETHOD.
ENDCLASS.