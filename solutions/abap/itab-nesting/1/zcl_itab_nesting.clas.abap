* Dedicated to Shree DR.MDD
CLASS zcl_itab_nesting DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    TYPES: BEGIN OF artists_type,
             artist_id   TYPE string,
             artist_name TYPE string,
           END OF artists_type.
    TYPES artists TYPE STANDARD TABLE OF artists_type WITH KEY artist_id.

    TYPES: BEGIN OF albums_type,
             artist_id  TYPE string,
             album_id   TYPE string,
             album_name TYPE string,
           END OF albums_type.
    TYPES albums TYPE STANDARD TABLE OF albums_type WITH KEY artist_id album_id.

    TYPES: BEGIN OF songs_type,
             artist_id TYPE string,
             album_id  TYPE string,
             song_id   TYPE string,
             song_name TYPE string,
           END OF songs_type.
    TYPES songs TYPE STANDARD TABLE OF songs_type WITH KEY artist_id album_id song_id.

    TYPES: BEGIN OF song_nested_type,
             song_id   TYPE string,
             song_name TYPE string,
           END OF song_nested_type.
    TYPES: BEGIN OF album_song_nested_type,
             album_id   TYPE string,
             album_name TYPE string,
             songs      TYPE STANDARD TABLE OF song_nested_type WITH KEY song_id,
           END OF album_song_nested_type.
    TYPES: BEGIN OF artist_album_nested_type,
             artist_id   TYPE string,
             artist_name TYPE string,
             albums      TYPE STANDARD TABLE OF album_song_nested_type WITH KEY album_id,
           END OF artist_album_nested_type.
    TYPES nested_data TYPE STANDARD TABLE OF artist_album_nested_type WITH KEY artist_id.

    METHODS perform_nesting
      IMPORTING
        artists            TYPE artists
        albums             TYPE albums
        songs              TYPE songs
      RETURNING
        VALUE(nested_data) TYPE nested_data.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_itab_nesting IMPLEMENTATION.

  METHOD perform_nesting.
    LOOP AT artists ASSIGNING FIELD-SYMBOL(<artist_row>).
      APPEND INITIAL LINE TO nested_data ASSIGNING FIELD-SYMBOL(<nested_artist>).
      MOVE-CORRESPONDING <artist_row> TO <nested_artist>.
      LOOP AT albums ASSIGNING FIELD-SYMBOL(<album_row>) WHERE artist_id = <artist_row>-artist_id.
        APPEND INITIAL LINE TO <nested_artist>-albums ASSIGNING FIELD-SYMBOL(<nested_album>).
        MOVE-CORRESPONDING <album_row> TO <nested_album>.
        LOOP AT songs ASSIGNING FIELD-SYMBOL(<song_row>) WHERE artist_id = <artist_row>-artist_id AND album_id = <album_row>-album_id.
          APPEND INITIAL LINE TO <nested_album>-songs ASSIGNING FIELD-SYMBOL(<nested_song>).
          MOVE-CORRESPONDING <song_row> TO <nested_song>.
        ENDLOOP.
      ENDLOOP.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
