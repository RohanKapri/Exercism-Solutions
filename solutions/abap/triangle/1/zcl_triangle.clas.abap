" Dedicated to Shree DR.MDD

CLASS zcl_triangle DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
      is_equilateral
        IMPORTING
          side_a             TYPE f
          side_b             TYPE f
          side_c             TYPE f
        RETURNING
          VALUE(result)      TYPE abap_bool
        RAISING
          cx_parameter_invalid,
      is_isosceles
        IMPORTING
          side_a             TYPE f
          side_b             TYPE f
          side_c             TYPE f
        RETURNING
          VALUE(result)      TYPE abap_bool
        RAISING
          cx_parameter_invalid,
      is_scalene
        IMPORTING
          side_a             TYPE f
          side_b             TYPE f
          side_c             TYPE f
        RETURNING
          VALUE(result)      TYPE abap_bool
        RAISING
          cx_parameter_invalid.

  PROTECTED SECTION.
  PRIVATE SECTION.

    METHODS: is_triangle
      IMPORTING
          side_a             TYPE f
          side_b             TYPE f
          side_c             TYPE f
        RETURNING
          VALUE(result)      TYPE abap_bool.
ENDCLASS.

CLASS zcl_triangle IMPLEMENTATION.

  METHOD is_triangle.
    DATA(sum_ab) = side_a + side_b.
    DATA(sum_bc) = side_b + side_c.
    DATA(sum_ac) = side_a + side_c.

    IF ( sum_ab >= side_c AND sum_bc >= side_a AND sum_ac >= side_b ) AND ( side_a > 0 AND side_b > 0 AND side_c > 0 ).
      result = abap_true.
    ELSE.
      result = abap_false.
    ENDIF.
  ENDMETHOD.

  METHOD is_equilateral.
    IF ( NOT is_triangle( side_a = side_a side_b = side_b side_c = side_c ) ).
      RAISE EXCEPTION TYPE cx_parameter_invalid.
    ENDIF.

    IF ( side_a = side_b AND side_b = side_c ).
      result = abap_true.
    ELSE.
      result = abap_false.
    ENDIF.
  ENDMETHOD.

  METHOD is_isosceles.
    IF ( NOT is_triangle( side_a = side_a side_b = side_b side_c = side_c ) ).
      RAISE EXCEPTION TYPE cx_parameter_invalid.
    ENDIF.

    IF ( side_a = side_b OR side_b = side_c OR side_c = side_a ).
      result = abap_true.
    ELSE.
      result = abap_false.
    ENDIF.
  ENDMETHOD.

  METHOD is_scalene.
    IF ( NOT is_triangle( side_a = side_a side_b = side_b side_c = side_c ) ).
      RAISE EXCEPTION TYPE cx_parameter_invalid.
    ENDIF.

    IF ( side_a <> side_b AND side_b <> side_c AND side_a <> side_c ).
      result = abap_true.
    ELSE.
      result = abap_false.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
