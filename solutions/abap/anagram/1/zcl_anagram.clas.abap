* Dedicated to Shree DR.MDD
CLASS zcl_anagram DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS anagram
      IMPORTING
        input         TYPE string
        candidates    TYPE string_table
      RETURNING
        VALUE(result) TYPE string_table.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_anagram IMPLEMENTATION.
  METHOD anagram.
    DATA candidate_list TYPE string_table.
    DATA source       TYPE string.
    DATA current_char TYPE c LENGTH 1.

    candidate_list = candidates[].
    source = input.

    DO strlen( source ) TIMES.
      LOOP AT candidate_list ASSIGNING FIELD-SYMBOL(<entry>).
        current_char = source(1).

        REPLACE FIRST OCCURRENCE OF to_lower( current_char ) IN <entry> WITH ` `.
        IF sy-subrc <> 0.
          REPLACE FIRST OCCURRENCE OF to_upper( current_char ) IN <entry> WITH ` `.
          IF sy-subrc <> 0.
            <entry> = '-'.
          ENDIF.
        ENDIF.
      ENDLOOP.
      SHIFT source LEFT.
    ENDDO.

    LOOP AT candidate_list TRANSPORTING NO FIELDS WHERE table_line CO ` `.
      READ TABLE candidates ASSIGNING FIELD-SYMBOL(<cand_entry>) INDEX sy-tabix.
      IF sy-subrc = 0 AND to_upper( <cand_entry> ) <> to_upper( input ).
        APPEND <cand_entry> TO result.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
