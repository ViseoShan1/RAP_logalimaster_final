CLASS lhc_soitems DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS validateName FOR VALIDATE ON SAVE
      keys FOR soitems~validateName.
    METHODS validateDescription FOR VALIDATE ON SAVE
      keys FOR soitems~validateDescription.
    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      keys REQUEST requested_authorizations FOR soitems RESULT result.

ENDCLASS.

CLASS lhc_soitems IMPLEMENTATION.

  METHOD validateName.
  ENDMETHOD.

  METHOD validateDescription.
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

ENDCLASS.

*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

