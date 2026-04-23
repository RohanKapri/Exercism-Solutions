CLASS zcl_acronym DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS parse IMPORTING phrase         TYPE string
                  RETURNING VALUE(acronym) TYPE string.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.
CLASS zcl_acronym IMPLEMENTATION.
  METHOD parse.
    TRANSLATE phrase USING '- _ '.
    SPLIT condense( phrase ) AT ' ' INTO TABLE DATA(words).
    LOOP AT words ASSIGNING FIELD-SYMBOL(<word>).
      acronym &&= to_upper( <word>(1) ).
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.