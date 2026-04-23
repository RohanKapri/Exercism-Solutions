* Dedicated to Shree DR.MDD
CLASS zcl_word_count DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES:
      BEGIN OF return_structure,
        word  TYPE string,
        count TYPE i,
      END OF return_structure,
      return_table TYPE STANDARD TABLE OF return_structure WITH KEY word.
    METHODS count_words
      IMPORTING
        !phrase       TYPE string
      RETURNING
        VALUE(result) TYPE return_table .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_word_count IMPLEMENTATION.

  METHOD count_words.
    DATA(normalized_phrase) = replace( val = to_lower( phrase ) sub = `'` with = `` occ = 0 ).
    normalized_phrase = replace( val = normalized_phrase sub = `\n` with = ` ` occ = 0 ).
    normalized_phrase = replace( val = normalized_phrase sub = `\t` with = ` ` occ = 0 ).
    normalized_phrase = replace( val = normalized_phrase regex = `[^a-z0-9]` with = ` ` occ = 0 ).

    SPLIT condense( normalized_phrase ) AT ` ` INTO TABLE DATA(word_entries).

    LOOP AT word_entries INTO DATA(current_word).
      DATA(temp_entry) = VALUE return_structure( word = current_word count = 1 ).
      READ TABLE result ASSIGNING FIELD-SYMBOL(<found>) WITH TABLE KEY word = temp_entry-word.
      IF sy-subrc = 0.
        <found>-count = <found>-count + temp_entry-count.
      ELSE.
        INSERT temp_entry INTO TABLE result.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
