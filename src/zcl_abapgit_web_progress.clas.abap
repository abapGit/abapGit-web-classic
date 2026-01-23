CLASS zcl_abapgit_web_progress DEFINITION PUBLIC FINAL CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES zif_abapgit_progress.

  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA mv_total TYPE i.

ENDCLASS.



CLASS zcl_abapgit_web_progress IMPLEMENTATION.

  METHOD zif_abapgit_progress~show.

    zcl_abapgit_persistence_db=>get_instance( )->modify(
      iv_type  = 'PROGRESS'
      iv_value = sy-uname
      iv_data  = iv_text ).

  ENDMETHOD.


  METHOD zif_abapgit_progress~set_total.
    mv_total = iv_total.
  ENDMETHOD.


  METHOD zif_abapgit_progress~off.

    zcl_abapgit_persistence_db=>get_instance( )->delete(
      iv_type  = 'PROGRESS'
      iv_value = sy-uname ).

  ENDMETHOD.

ENDCLASS.
