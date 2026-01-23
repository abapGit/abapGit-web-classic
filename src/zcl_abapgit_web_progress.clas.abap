CLASS zcl_abapgit_web_progress DEFINITION PUBLIC FINAL CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES zif_abapgit_progress.

    CONSTANTS c_type TYPE zif_abapgit_persistence=>ty_type VALUE 'PROGRESS'.

  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA mv_total TYPE i.

ENDCLASS.



CLASS zcl_abapgit_web_progress IMPLEMENTATION.

  METHOD zif_abapgit_progress~show.

    DATA ls_content TYPE zabapgit.
    ls_content-type  = c_type.
    ls_content-value = sy-uname.
    ls_content-data_str = iv_txt.

    MODIFY zabapgit FROM ls_content.

"     zcl_abapgit_persistence_db=>get_instance( )->modify(
"       iv_type  = c_type
"       iv_value = sy-uname
"       iv_data  = iv_text ).

" * and wait for releasing the lock
"     COMMIT WORK AND WAIT.

  ENDMETHOD.


  METHOD zif_abapgit_progress~set_total.
    mv_total = iv_total.
  ENDMETHOD.


  METHOD zif_abapgit_progress~off.

    " zcl_abapgit_persistence_db=>get_instance( )->delete(
    "   iv_type  = c_type
    "   iv_value = sy-uname ).

    " COMMIT WORK AND WAIT.

  ENDMETHOD.

ENDCLASS.
