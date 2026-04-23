* Dedicated to Shree DR.MDD
CLASS zcl_prime_factors DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES integertab TYPE STANDARD TABLE OF i WITH EMPTY KEY.
    METHODS factors
      IMPORTING
        input         TYPE int8
      RETURNING
        VALUE(result) TYPE integertab.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.

CLASS zcl_prime_factors IMPLEMENTATION.
  METHOD factors.
    CHECK input > 1.
    DATA(curr_val) = input.
    DATA(prime_candidate) = 2.
    DO.
      IF curr_val MOD prime_candidate = 0.
        INSERT prime_candidate INTO TABLE result.
        curr_val = curr_val DIV prime_candidate.
        IF curr_val = 1.
          EXIT.
        ENDIF.
      ELSE.
        prime_candidate = prime_candidate + 1.
        IF prime_candidate MOD 2 = 0.
          prime_candidate = prime_candidate + 1.
        ENDIF.
      ENDIF.
    ENDDO.
  ENDMETHOD.

ENDCLASS.
