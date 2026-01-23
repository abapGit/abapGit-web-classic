CLASS zcl_abapgit_html_viewer_web DEFINITION PUBLIC FINAL CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES zif_abapgit_html_viewer.

    METHODS constructor
      IMPORTING
        ii_request  TYPE REF TO zif_abapgit_web_request
        ii_response TYPE REF TO zif_abapgit_web_response.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA mv_html   TYPE string.
    DATA mv_css    TYPE string.
    DATA mi_request  TYPE REF TO zif_abapgit_web_request.
    DATA mi_response TYPE REF TO zif_abapgit_web_response.
ENDCLASS.



CLASS zcl_abapgit_html_viewer_web IMPLEMENTATION.


  METHOD constructor.
    mi_request = ii_request.
    mi_response = ii_response.
  ENDMETHOD.


  METHOD zif_abapgit_html_viewer~back.
    RETURN.
  ENDMETHOD.


  METHOD zif_abapgit_html_viewer~close_document.
    RETURN.
  ENDMETHOD.


  METHOD zif_abapgit_html_viewer~free.
    RETURN.
  ENDMETHOD.


  METHOD zif_abapgit_html_viewer~get_url.
    RETURN.
  ENDMETHOD.


  METHOD zif_abapgit_html_viewer~load_data.

    IF iv_url = 'css/bundle.css'.
      CONCATENATE LINES OF ct_data_table INTO mv_css IN CHARACTER MODE RESPECTING BLANKS.
    ELSEIF iv_url = ''.
      CONCATENATE LINES OF ct_data_table INTO mv_html IN CHARACTER MODE RESPECTING BLANKS.
    ENDIF.

  ENDMETHOD.


  METHOD zif_abapgit_html_viewer~set_focus.
    RETURN.
  ENDMETHOD.


  METHOD zif_abapgit_html_viewer~set_registered_events.
    RETURN.
  ENDMETHOD.


  METHOD zif_abapgit_html_viewer~set_visiblity.
    RETURN.
  ENDMETHOD.


  METHOD zif_abapgit_html_viewer~show_url.

    DATA lv_path TYPE string.
    DATA lv_js   TYPE string.

    lv_path = cl_http_utility=>unescape_url( mi_request->get_header_field( '~path' ) ).

    lv_js = |<script>                                     \n| &&
      |function registerLinks() \{                        \n| &&
      |  const links = document.getElementsByTagName("a");\n| &&
      |  for (let i = 0; i < links.length; i++) \{        \n| &&
      |    if (links[i].href.startsWith("sapevent:")) \{  \n| &&
      |      links[i].href = "./" + links[i].href;        \n| &&
      |    \}                                             \n| &&
      |  \}                                               \n| &&
      |\}                                                 \n| &&
      |registerLinks();                                   \n| &&
      |                                                   \n| &&
      |function registerForms() \{                              \n| &&
      |  const forms = document.getElementsByTagName("form");   \n| &&
      |  for (let i = 0; i < forms.length; i++) \{              \n| &&
      |    if (forms[i].action.startsWith("sapevent:")) \{\n| &&
      |      console.log("abapGit: rewrite form action " + forms[i].action);\n| &&
      |      forms[i].action = "./" + forms[i].action;            \n| &&
      |    \}                                                     \n| &&
      |  \}                                                     \n| &&
      |  const inputs = document.getElementsByTagName("input"); \n| &&
      |  for (let i = 0; i < inputs.length; i++) \{             \n| &&
      |    if (inputs[i].type === "submit"                          \n| &&
      |        && inputs[i].formAction.startsWith("sapevent:")) \{  \n| &&
      |      inputs[i].formAction = "./" + inputs[i].formAction;    \n| &&
      |    \}                                                       \n| &&
      |  \}                                                     \n| &&
      |\}                                                       \n| &&
      |registerForms();                                         \n| &&
      |                                                   \n| &&
      |const PROGRESS_INTERVAL = 200;\n| &&
      |                                                   \n| &&
      |function getOrCreateProgressModal() \{\n| &&
      |  let modal = document.getElementById("progressModal");\n| &&
      |  if (!modal) \{\n| &&
      |    modal = document.createElement("div");\n| &&
      |    modal.id = "progressModal";\n| &&
      |    modal.style.cssText = "display:none;position:fixed;top:0;left:0;width:100%;height:100%;background:rgba(0,0,0,0.5);z-index:9999;justify-content:center;align-items:center;";\n| &&
      |    const content = document.createElement("div");\n| &&
      |    content.id = "progressModalContent";\n| &&
      |    content.style.cssText = "background:white;padding:20px;border-radius:8px;min-width:300px;text-align:center;box-shadow:0 4px 6px rgba(0,0,0,0.3);";\n| &&
      |    modal.appendChild(content);\n| &&
      |    document.body.appendChild(modal);\n| &&
      |  \}\n| &&
      |  return modal;\n| &&
      |\}\n| &&
      |                                                   \n| &&
      |function showProgressModal(text) \{\n| &&
      |  const modal = getOrCreateProgressModal();\n| &&
      |  const content = document.getElementById("progressModalContent");\n| &&
      |  content.textContent = text;\n| &&
      |  modal.style.display = "flex";\n| &&
      |\}\n| &&
      |                                                   \n| &&
      |function hideProgressModal() \{\n| &&
      |  const modal = document.getElementById("progressModal");\n| &&
      |  if (modal) \{\n| &&
      |    modal.style.display = "none";\n| &&
      |  \}\n| &&
      |\}\n| &&
      |                                                   \n| &&
      |function checkForProgress() \{\n| &&
      |  console.dir("checkForProgress");\n| &&
      |  fetch("/sap/zabapgit_statel", \{ keepalive: true \})\n| &&
      |    .then(response => response.text())\n| &&
      |    .then(data => \{\n| &&
      |      console.dir(data);\n| &&
      |      if (data && data.trim() !== "") \{\n| &&
      |        showProgressModal(data);\n| &&
      |      \} else \{\n| &&
      |        hideProgressModal();\n| &&
      |      \}\n| &&
      |      setTimeout(checkForProgress, PROGRESS_INTERVAL);\n| &&
      |    \});\n| &&
      |\}\n| &&
      |                                                   \n| &&
      |window.onbeforeunload = () => \{\n| &&
      |  console.dir("onbeforeunload"); \n| &&
      |  setTimeout(checkForProgress, PROGRESS_INTERVAL);\n| &&
      |\};\n| &&
      |window.onunload = () => \{\n| &&
      |  console.dir("onunload");\n| &&
      |\};\n| &&
      |</script></body>\n|.

    IF lv_path = '/sap/zabapgit/css/bundle.css'.
      mi_response->set_content_type( 'text/css' ).
      mi_response->set_cdata( mv_css ).
    ELSEIF lv_path = '/sap/zabapgit/' OR lv_path CP |/sap/zabapgit/sapevent:+*|.
      REPLACE FIRST OCCURRENCE OF |</body>| IN mv_html WITH lv_js.
      mi_response->set_content_type( 'text/html' ).
* note: fixing this on client side wont work for SSL/https connections, it gives a warning
      REPLACE ALL OCCURRENCES OF 'action="sapevent:' IN mv_html WITH 'action="./sapevent:'.
      mi_response->set_cdata( mv_html ).
    ELSE.
      mi_response->set_content_type( 'text/html' ).
      mi_response->set_cdata( |show_url, unknown path { lv_path }| ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
