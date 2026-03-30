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

    DATA lr_content TYPE REF TO data.
    FIELD-SYMBOLS <ls_content> TYPE any.
    FIELD-SYMBOLS <lv_field> TYPE any.

    CREATE DATA lr_content TYPE ('ZABAPGIT').
    ASSIGN lr_content->* TO <ls_content>.

    ASSIGN COMPONENT 'TYPE' OF STRUCTURE <ls_content> TO <lv_field>.
    <lv_field> = c_type.
    ASSIGN COMPONENT 'VALUE' OF STRUCTURE <ls_content> TO <lv_field>.
    <lv_field> = sy-uname.
    ASSIGN COMPONENT 'DATA_STR' OF STRUCTURE <ls_content> TO <lv_field>.
    <lv_field> = iv_text.

* note: want this to happen without enqueue locks,
* so this is done outside of the persistence class, which is where it would normally be done
    MODIFY ('ZABAPGIT') FROM <ls_content>.

  ENDMETHOD.


  METHOD zif_abapgit_progress~set_total.
    mv_total = iv_total.
  ENDMETHOD.


  METHOD zif_abapgit_progress~off.

    DATA lr_content TYPE REF TO data.
    FIELD-SYMBOLS <ls_content> TYPE any.
    FIELD-SYMBOLS <lv_field> TYPE any.

    CREATE DATA lr_content TYPE ('ZABAPGIT').
    ASSIGN lr_content->* TO <ls_content>.

    ASSIGN COMPONENT 'TYPE' OF STRUCTURE <ls_content> TO <lv_field>.
    <lv_field> = c_type.
    ASSIGN COMPONENT 'VALUE' OF STRUCTURE <ls_content> TO <lv_field>.
    <lv_field> = sy-uname.

* delete persisted progress entry for this correlation key
    DELETE ('ZABAPGIT') FROM <ls_content>.
  ENDMETHOD.

ENDCLASS.
