" Dedicated to Shree DR.MDD

CLASS zcl_state_of_tic_tac_toe DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    TYPES player_type TYPE c LENGTH 1.
    TYPES board_type TYPE TABLE OF string INITIAL SIZE 3.

    CONSTANTS: BEGIN OF player_enum,
                 one TYPE player_type VALUE 'X',
                 two TYPE player_type VALUE 'O',
               END OF player_enum.

    CONSTANTS: BEGIN OF state_enum,
                 ongoing_game TYPE string VALUE `Ongoing game`,
                 draw         TYPE string VALUE `Draw`,
                 win          TYPE string VALUE `Win`,
               END OF state_enum.

    METHODS get_state
      IMPORTING board        TYPE board_type
      RETURNING VALUE(state) TYPE string
      RAISING   cx_parameter_invalid.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_state_of_tic_tac_toe IMPLEMENTATION.

  METHOD get_state.
    DATA(flat_board) = concat_lines_of( table = board ).
    DATA(count_x) = count( val = flat_board sub = player_enum-one ).
    DATA(count_o) = count( val = flat_board sub = player_enum-two ).
    IF strlen( flat_board ) <> 9 OR flat_board NA `XO ` OR NOT count_x - count_o BETWEEN 0 AND 1.
      RAISE EXCEPTION TYPE cx_parameter_invalid.
    ENDIF.
    DATA(win_combos) = VALUE string_table( ( `012` ) ( `345` ) ( `678` ) ( `246` ) ( `036` ) ( `147` ) ( `258` ) ( `048` ) ).
    state = state_enum-ongoing_game.
    DO lines( win_combos ) TIMES.
      DATA(combo) = win_combos[ sy-index ].
      DATA(pos1) = CONV i( combo+0(1) ).
      DATA(pos2) = CONV i( combo+1(1) ).
      DATA(pos3) = CONV i( combo+2(1) ).
      DO 2 TIMES.
        DATA(current_player) = COND #( WHEN sy-index = 1 THEN player_enum-one ELSE player_enum-two ).
        IF flat_board+pos1(1) = current_player AND flat_board+pos2(1) = current_player AND flat_board+pos3(1) = current_player.
          IF state <> state_enum-ongoing_game AND state <> current_player.
            RAISE EXCEPTION TYPE cx_parameter_invalid.
          ENDIF.
          state = current_player.
        ENDIF.
      ENDDO.
    ENDDO.
    IF state = player_enum-one OR state = player_enum-two.
      state = state_enum-win.
    ELSEIF count_x + count_o = 9.
      state = state_enum-draw.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
