" Dedicated to Shree DR.MDD

CLASS zcl_book_store DEFINITION PUBLIC FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    TYPES book_id TYPE i.
    TYPES basket_type TYPE SORTED TABLE OF book_id WITH NON-UNIQUE KEY table_line.
    TYPES total TYPE p LENGTH 3 DECIMALS 2.
    METHODS calculate_total
      IMPORTING basket       TYPE basket_type
      RETURNING VALUE(total) TYPE total.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_book_store IMPLEMENTATION.
METHOD calculate_total.
    TYPES: BEGIN OF line_agg,
             id       TYPE book_id,
             qty      TYPE i,
           END OF line_agg.
    TYPES: BEGIN OF disc_group,
             unique_count TYPE i,
             rate         TYPE total,
           END OF disc_group.

    DATA: basket_ref TYPE REF TO line_agg,
          aggregated_basket TYPE TABLE OF line_agg WITH NON-UNIQUE SORTED KEY qty COMPONENTS qty,
          line_ref TYPE REF TO book_id,
          active_basket TYPE TABLE OF line_agg,
          grp_ref TYPE REF TO disc_group,
          discount_table TYPE TABLE OF disc_group,
          current_total TYPE total.

    discount_table = VALUE #( ( unique_count = 5 rate = '0.25' )
                              ( unique_count = 4 rate = '0.20' )
                              ( unique_count = 3 rate = '0.10' )
                              ( unique_count = 2 rate = '0.05' )
                              ( unique_count = 1 rate = 0 ) ).
    total = 999.
    DATA(max_unique) = 5.
    DO 5 TIMES.
      current_total = 0.
      aggregated_basket = VALUE #( ( id = 1 )
                                    ( id = 2 )
                                    ( id = 3 )
                                    ( id = 4 )
                                    ( id = 5 ) ).

      LOOP AT basket REFERENCE INTO line_ref.
        aggregated_basket[ id = line_ref->* ]-qty = aggregated_basket[ id = line_ref->* ]-qty + 1.
      ENDLOOP.

      LOOP AT discount_table REFERENCE INTO grp_ref WHERE unique_count <= max_unique.
        DO.
          CLEAR active_basket.
          LOOP AT aggregated_basket REFERENCE INTO basket_ref WHERE qty > 0.
            APPEND basket_ref->* TO active_basket.
          ENDLOOP.
          IF lines( active_basket ) < grp_ref->unique_count.
            EXIT.
          ENDIF.
          SORT aggregated_basket BY qty DESCENDING.
          DO grp_ref->unique_count TIMES.
            aggregated_basket[ sy-index ]-qty = aggregated_basket[ sy-index ]-qty - 1.
          ENDDO.
          current_total = current_total + grp_ref->unique_count * 8 * ( 1 - grp_ref->rate ).
        ENDDO.
      ENDLOOP.
      total = nmin( val1 = total val2 = current_total ).
      max_unique = max_unique - 1.
    ENDDO.
  ENDMETHOD.
ENDCLASS.
