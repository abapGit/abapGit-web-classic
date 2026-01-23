CLASS zcl_abapgit_web_sicf_stateless DEFINITION PUBLIC.
  PUBLIC SECTION.
    INTERFACES if_http_extension.
ENDCLASS.

CLASS zcl_abapgit_web_sicf_stateless IMPLEMENTATION.

  METHOD if_http_extension~handle_request.

    DATA lv_data TYPE string.

    server->response->set_header_field(
      name  = 'Content-Type'
      value = 'text/html' ).
    server->response->set_header_field(
      name  = 'Expires'
      value = '0' ).

    TRY.
        lv_data = zcl_abapgit_persistence_db=>get_instance( )->read(
          iv_type  = zcl_abapgit_web_progress=>c_type
          iv_value = sy-uname ).
      CATCH zcx_abapgit_not_found.
    ENDTRY.

    lv_data = '<html><body>hello world' && lv_data && '</body></html>'.

    server->response->set_cdata( lv_data ).

  ENDMETHOD.

ENDCLASS.
