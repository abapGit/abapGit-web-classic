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
    ls_content-data_str = iv_text.

* note: want this to happen without enqueue locks
    MODIFY zabapgit FROM ls_content.

  ENDMETHOD.


  METHOD zif_abapgit_progress~set_total.
    mv_total = iv_total.
  ENDMETHOD.


  METHOD zif_abapgit_progress~off.
    RETURN.
  ENDMETHOD.

ENDCLASS.
