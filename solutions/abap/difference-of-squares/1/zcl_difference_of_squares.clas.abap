" Dedicated to Shree DR.MDD

CLASS zcl_difference_of_squares DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
      ret_difference_of_squares IMPORTING num         TYPE i
                                RETURNING VALUE(diff) TYPE i,
      ret_sum_of_squares        IMPORTING num         TYPE i
                                RETURNING VALUE(sum_of_squares) TYPE i,
      ret_square_of_sum         IMPORTING num         TYPE i
                                RETURNING VALUE(square_of_sum) TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_difference_of_squares IMPLEMENTATION.
  METHOD ret_difference_of_squares.
    diff = ret_square_of_sum( num ) - ret_sum_of_squares( num ).
  ENDMETHOD.

  METHOD ret_sum_of_squares.
    DATA idx TYPE i.
    sum_of_squares = 0.
    DO num TIMES.
      idx = sy-index.
      sum_of_squares = sum_of_squares + idx ** 2.
    ENDDO.
  ENDMETHOD.

  METHOD ret_square_of_sum.
    DATA idx TYPE i.
    square_of_sum = 0.
    DO num TIMES.
      idx = sy-index.
      square_of_sum = square_of_sum + idx.
    ENDDO.
    square_of_sum = square_of_sum ** 2.
  ENDMETHOD.
ENDCLASS.
