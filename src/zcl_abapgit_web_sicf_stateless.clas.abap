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

    lv_data = '<html><body>hello world</body></html>'.

    server->response->set_cdata( lv_data ).

  ENDMETHOD.

ENDCLASS.
