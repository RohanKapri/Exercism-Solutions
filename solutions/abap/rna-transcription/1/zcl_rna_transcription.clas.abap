" Dedicated to Shree DR.MDD

CLASS zcl_rna_transcription DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS
      transcribe
        IMPORTING
          dna_sequence       TYPE string
        RETURNING
          VALUE(result)      TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.

CLASS zcl_rna_transcription IMPLEMENTATION.

  METHOD transcribe.
    result = dna_sequence.
    TRANSLATE result USING 'GCCGTAAU'. " DNA->RNA transcription mapping
  ENDMETHOD.

ENDCLASS.
