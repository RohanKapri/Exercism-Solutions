CLASS zcl_affine_cipher DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    TYPES: BEGIN OF key,
             a TYPE i,
             b TYPE i,
           END OF key.

    METHODS:
      encode IMPORTING phrase        TYPE string
                       key           TYPE key
             RETURNING VALUE(cipher) TYPE string
             RAISING   cx_parameter_invalid,
      decode IMPORTING cipher        TYPE string
                       key           TYPE key
             RETURNING VALUE(phrase) TYPE string
             RAISING   cx_parameter_invalid.
  PROTECTED SECTION.
    METHODS: check_coprime IMPORTING key           TYPE key
                RETURNING VALUE(coprime) TYPE c.

  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_affine_cipher IMPLEMENTATION.
  METHOD encode.

    IF check_coprime( key ) IS INITIAL.
      RAISE EXCEPTION TYPE cx_parameter_invalid.
    ENDIF.

    DATA nb_letters TYPE i.
    DATA(alphabet) = to_lower( sy-abcde ).
    phrase = replace( val = phrase regex = '[^a-zA-Z0-9 ]' with = '' occ = 0 ).

    CONDENSE phrase NO-GAPS.
    DO strlen( phrase ) TIMES.
      IF nb_letters = 5.
        cipher = |{ cipher } |.
        nb_letters = 0.
      ENDIF.

      DATA(offset) = sy-index - 1.
      FIND FIRST OCCURRENCE OF to_lower( phrase+offset(1) ) IN alphabet MATCH OFFSET DATA(pos).
      IF sy-subrc NE 0.
        cipher = |{ cipher }{ phrase+offset(1) }|.
      ELSE.
        pos = ( key-a * pos + key-b ) MOD 26.
        cipher = |{ cipher }{ alphabet+pos(1) }|.
      ENDIF.
      nb_letters += 1.
    ENDDO.
  ENDMETHOD.

  METHOD decode.
    DATA : i TYPE i.
    IF check_coprime( key ) IS INITIAL.
      RAISE EXCEPTION TYPE cx_parameter_invalid.
    ENDIF.

    DATA(alphabet) = to_lower( sy-abcde ).
    cipher = replace( val = cipher regex = '[^a-zA-Z0-9 ]' with = '' occ = 0 ).

        WHILE i < 26.
          IF ( key-a * i ) MOD 26 = 1.
            DATA(mmi) = i.
            EXIT.
          ENDIF.
          i += 1.
        ENDWHILE.

    CONDENSE cipher NO-GAPS.
    DO strlen( cipher ) TIMES.
      DATA(offset) = sy-index - 1.
      FIND FIRST OCCURRENCE OF to_lower( cipher+offset(1) ) IN alphabet MATCH OFFSET DATA(pos).
      IF sy-subrc NE 0.
        phrase = |{ phrase }{ cipher+offset(1) }|.
      ELSE.
        pos = mmi * ( pos - key-b ) MOD 26.
        phrase = |{ phrase }{ alphabet+pos(1) }|.
      ENDIF.
    ENDDO.

  ENDMETHOD.

  METHOD check_coprime.

    coprime = abap_true.

    DATA(i) = 2.
    WHILE i <= key-a.
      IF key-a MOD i = 0 AND 26 MOD i = 0.
        coprime = abap_false.
        RETURN.
      ELSE.
        i += 1.
      ENDIF.
    ENDWHILE.
  ENDMETHOD.

ENDCLASS.