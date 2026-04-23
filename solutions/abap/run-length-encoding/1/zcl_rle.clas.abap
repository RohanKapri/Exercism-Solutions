CLASS zcl_rle DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES: BEGIN OF character_typ,
             letter TYPE C,
             count  TYPE I,
           END OF character_typ.
    TYPES: character_tab TYPE SORTED TABLE OF character_typ WITH UNIQUE KEY letter.
    METHODS encode IMPORTING input         TYPE string
                   RETURNING VALUE(result) TYPE string.

    METHODS decode IMPORTING input         TYPE string
                   RETURNING VALUE(result) TYPE string.

ENDCLASS.


CLASS zcl_rle IMPLEMENTATION.

  METHOD encode.
    IF input = ``.
      result = ``.
      RETURN.
    ENDIF.
    DATA:
          iv_state   TYPE I,
          idx        TYPE I,
          curr_count TYPE I,
          last_char  TYPE string,
          curr_char  TYPE string.
    iv_state = 1.
    idx = 0.
    WHILE idx < strlen( input ).
      curr_char = input+idx(1).
      CASE iv_state.
        WHEN 1.
          last_char = curr_char.
          curr_count = 1.
          iv_state = 2.
        WHEN 2.
          IF last_char = curr_char.
            curr_count = curr_count + 1.
          ELSE.
            IF curr_count = 1.
              result = result && last_char.
            ELSE.
              result = result && curr_count && last_char.
            ENDIF.
            last_char = curr_char.
            curr_count = 1.
          ENDIF.
      ENDCASE.
      idx = idx + 1.
    ENDWHILE.
    IF curr_count = 1.
      result = result && last_char.
    ELSE.
      result = result && curr_count && last_char.
    ENDIF.
  ENDMETHOD.


  METHOD decode.
    IF input = ``.
      result = ``.
      RETURN.
    ENDIF.
    DATA:
          one_match        TYPE string,
          num_section      TYPE string,
          num_section_conv TYPE I,
          char_section     TYPE string,
          was_last_match   TYPE abap_bool,
          insert_counter   TYPE I.
    was_last_match = abap_true.
    WHILE was_last_match = abap_true.
      was_last_match = abap_false.
      FIND PCRE `((\d+)?\D)` IN input SUBMATCHES one_match.
      IF SY-SUBRC = 0.
        was_last_match = abap_true.
        REPLACE FIRST OCCURENCE OF PCRE `((\d+)?\D)` IN input WITH ''.
        FIND PCRE `(\d+)` IN one_match SUBMATCHES num_section.
        IF SY-SUBRC <> 0.
          FIND PCRE `(\D)` IN one_match SUBMATCHES char_section.
          result = result && char_section.
        ELSE.
          FIND PCRE `(\D)` IN one_match SUBMATCHES char_section.
          num_section_conv = num_section.
          insert_counter = 1.
          WHILE insert_counter <= num_section_conv.
            result = result && char_section.
            insert_counter = insert_counter + 1.
          ENDWHILE.
        ENDIF.
      ELSE.
        EXIT.
      ENDIF.
    ENDWHILE.
  ENDMETHOD.

ENDCLASS.

















