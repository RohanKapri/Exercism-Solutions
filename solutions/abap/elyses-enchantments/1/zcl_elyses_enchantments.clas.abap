CLASS zcl_elyses_enchantments DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES ty_stack TYPE STANDARD TABLE OF i WITH EMPTY KEY.

    "! Get card at position
    METHODS get_item
      IMPORTING stack         TYPE ty_stack
                position      TYPE i
      RETURNING VALUE(result) TYPE i.

    "! Replace card at position
    METHODS set_item
      IMPORTING stack         TYPE ty_stack
                position      TYPE i
                replacement   TYPE i
      RETURNING VALUE(result) TYPE ty_stack.

    "Add card to stack
    METHODS insert_item_at_top
      IMPORTING stack         TYPE ty_stack
                new_card      TYPE i
      RETURNING VALUE(result) TYPE ty_stack.

    "! Remove card at position
    METHODS remove_item
      IMPORTING stack         TYPE ty_stack
                position      TYPE i
      RETURNING VALUE(result) TYPE ty_stack.

    "! Remove top card (last row)
    METHODS remove_item_from_top
      IMPORTING stack         TYPE ty_stack
      RETURNING VALUE(result) TYPE ty_stack.

    "! Add card to bottom of stack (first row)
    METHODS insert_item_at_bottom
      IMPORTING stack         TYPE ty_stack
                new_card      TYPE i
      RETURNING VALUE(result) TYPE ty_stack.

    "! Remove bottom card (delete first row)
    METHODS remove_item_from_bottom
      IMPORTING stack         TYPE ty_stack
      RETURNING VALUE(result) TYPE ty_stack.

    "! Count cards
    METHODS get_size_of_stack
      IMPORTING stack         TYPE ty_stack
      RETURNING VALUE(result) TYPE i.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_elyses_enchantments IMPLEMENTATION.

  METHOD get_item.
    "Implement solution here
    DATA: lv_stack TYPE i.
    READ TABLE stack INTO lv_stack INDEX position.
    IF sy-subrc = 0.
      result = lv_stack.
    ELSE.
      result = 0.
    ENDIF.
  ENDMETHOD.


  METHOD set_item.
    "Implement solution here
    MODIFY stack INDEX position FROM replacement.
    IF sy-subrc = 0.
      result = stack.
    ELSE.
      "Continue.
    ENDIF.
  ENDMETHOD.


  METHOD insert_item_at_top.
    "Implement solution here
    INSERT new_card INTO TABLE stack.
    result = stack.
  ENDMETHOD.


  METHOD get_size_of_stack.
    "Implement solution here
    result = LINES( stack ).
  ENDMETHOD.


  METHOD insert_item_at_bottom.
    "Implement solution here
    INSERT new_card INTO stack INDEX 1.
    result = stack.
  ENDMETHOD.


  METHOD remove_item.
    "Implement solution here
    DELETE stack INDEX position.
    result = stack.
  ENDMETHOD.


  METHOD remove_item_from_bottom.
    "Implement solution here
    DELETE stack INDEX 1.
    result = stack.
  ENDMETHOD.


  METHOD remove_item_from_top.
    "Implement solution here
    DATA lv_top TYPE i. 
    LOOP AT stack ASSIGNING FIELD-SYMBOL(<ls_stack>).
    ENDLOOP.
    lv_top = sy-tabix.
    DELETE stack INDEX lv_top.
    result = stack.

  ENDMETHOD.

ENDCLASS.