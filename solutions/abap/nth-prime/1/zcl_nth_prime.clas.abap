* Dedicated to Shree DR.MDD
CLASS zcl_nth_prime DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS prime
      IMPORTING
        input         TYPE i
      RETURNING
        VALUE(result) TYPE i
      RAISING
        cx_parameter_invalid.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_nth_prime IMPLEMENTATION.

  METHOD prime.

    IF input = 0.
      RAISE EXCEPTION TYPE cx_parameter_invalid.
    ENDIF.

    DATA num_list TYPE STANDARD TABLE OF i WITH EMPTY KEY.
    DATA sieve_list TYPE STANDARD TABLE OF i WITH EMPTY KEY.
    DATA limit TYPE int8.
    DATA current_prime TYPE int8.
    DATA max_count TYPE i.
    DATA index TYPE i.

    max_count = input * input.
    IF max_count <= 1.
      max_count = 2.
    ENDIF.

    DO max_count TIMES.
      APPEND sy-tabix + 1 TO num_list.
    ENDDO.

    DELETE num_list INDEX 1.
    sieve_list = num_list.

    current_prime = 2.
    limit = max_count.

    WHILE current_prime * current_prime < limit.
      LOOP AT num_list ASSIGNING FIELD-SYMBOL(<n>).
        IF <n> MOD current_prime = 0 AND <n> <> current_prime.
          DELETE sieve_list WHERE table_line = <n>.
        ENDIF.
      ENDLOOP.
      current_prime = current_prime + 1.
    ENDWHILE.

    index = 0.
    LOOP AT sieve_list ASSIGNING FIELD-SYMBOL(<p>).
      index = index + 1.
      IF index = input.
        result = <p>.
        EXIT.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
