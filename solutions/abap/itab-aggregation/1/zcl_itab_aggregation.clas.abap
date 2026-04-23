CLASS zcl_itab_aggregation DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES group TYPE c LENGTH 1.
    TYPES: BEGIN OF initial_numbers_type,
             group  TYPE group,
             number TYPE i,
           END OF initial_numbers_type,
           initial_numbers TYPE STANDARD TABLE OF initial_numbers_type WITH EMPTY KEY.

    TYPES: BEGIN OF aggregated_data_type,
             group   TYPE group,
             count   TYPE i,
             sum     TYPE i,
             min     TYPE i,
             max     TYPE i,
             average TYPE f,
           END OF aggregated_data_type,
           aggregated_data TYPE STANDARD TABLE OF aggregated_data_type WITH EMPTY KEY.

    METHODS perform_aggregation
      IMPORTING
        initial_numbers        TYPE initial_numbers
      RETURNING
        VALUE(aggregated_data) TYPE aggregated_data.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_itab_aggregation IMPLEMENTATION.
  METHOD perform_aggregation.
    LOOP AT initial_numbers INTO DATA(ls_initial).
      ASSIGN aggregated_data[ group = ls_initial-group ] TO FIELD-SYMBOL(<fs_aggr>).
      if sy-subrc <> 0.
        APPEND INITIAL LINE TO aggregated_data ASSIGNING <fs_aggr>.
        <fs_aggr>-group = ls_initial-group.
      ENDIF.
      <fs_aggr>-count  += 1.
      <fs_aggr>-sum    += ls_initial-number. 
      <fs_aggr>-average = <fs_aggr>-sum / <fs_aggr>-count.
      <fs_aggr>-min = nmin( val1 = COND i( WHEN <fs_aggr>-min IS INITIAL THEN ls_initial-number ELSE <fs_aggr>-min ) val2 = ls_initial-number ).
      <fs_aggr>-max = nmax( val1 = COND i( WHEN <fs_aggr>-max IS INITIAL THEN ls_initial-number ELSE <fs_aggr>-max ) val2 = ls_initial-number ).
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.