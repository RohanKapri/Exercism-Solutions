* Dedicated to Shree DR.MDD
CLASS zcl_atbash_cipher DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    METHODS decode
      IMPORTING
        !cipher_text      TYPE string
      RETURNING
        VALUE(plain_text) TYPE string.
    METHODS encode
      IMPORTING
        !plain_text       TYPE string 
      RETURNING
        VALUE(cipher_text) TYPE string.
  PROTECTED SECTION.
  PRIVATE SECTION.  
ENDCLASS.

CLASS zcl_atbash_cipher IMPLEMENTATION.

  METHOD decode.
    plain_text = replace( 
      val  = encode( cipher_text )
      sub  = ` `
      with = ``
      occ  = 0 ).
  ENDMETHOD.

  METHOD encode.
    CONSTANTS abc_set TYPE string VALUE 'abcdefghijklmnopqrstuvwxyz'.
    DATA(clean_text) = replace( val   = to_lower( plain_text )
                                regex = `[ .,]`
                                with  = ``
                                occ   = 0 ).
    DATA(pos_idx) = 0.
    WHILE pos_idx < strlen( clean_text ).
      DATA(char_pos) = 25 - find( val = abc_set
                                   sub = clean_text+pos_idx(1) ).
      IF char_pos BETWEEN 0 AND 25.
        cipher_text = cipher_text && substring( val = abc_set
                                                off = char_pos
                                                len = 1 ).
      ELSE.
        cipher_text = cipher_text && clean_text+pos_idx(1).
      ENDIF.
      pos_idx = pos_idx + 1.
      IF pos_idx MOD 5 = 0 AND pos_idx < strlen( clean_text ).
        cipher_text = cipher_text && ` `.
      ENDIF.
    ENDWHILE.
  ENDMETHOD.

ENDCLASS.
