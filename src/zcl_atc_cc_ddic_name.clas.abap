CLASS zcl_atc_cc_ddic_name DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

PUBLIC SECTION.
  INTERFACES if_ci_atc_check.

  CONSTANTS:
    BEGIN OF constants,
      BEGIN OF checked_object_types,
        interface       TYPE c LENGTH 4 VALUE 'INTF',
        function_group  TYPE c LENGTH 4 VALUE 'FUGR',
        class           TYPE c LENGTH 4 VALUE 'CLAS',
        table_type      TYPE c LENGTH 4 VALUE 'TTYP',
        data_element    TYPE c LENGTH 4 VALUE 'DTEL',
        domain          TYPE c LENGTH 4 VALUE 'DOMA',
        structure       TYPE c LENGTH 4 VALUE 'TABL',
        cds             TYPE c LENGTH 4 VALUE 'DDLS',
        access_control  TYPE c LENGTH 4 VALUE 'DCLS',
        message_class   TYPE c LENGTH 4 VALUE 'MSAG',
      END OF checked_object_types,
    END OF constants.

  CLASS-DATA: prefixes TYPE if_ci_atc_check_meta_data=>ty_attributes.

  CLASS-METHODS:
    class_constructor.
PROTECTED SECTION.
PRIVATE SECTION.
  DATA:
    assistant_factory TYPE REF TO cl_ci_atc_assistant_factory.
ENDCLASS.



CLASS ZCL_ATC_CC_DDIC_NAME IMPLEMENTATION.


  METHOD class_constructor.
    DATA: string_table TYPE TABLE OF string.

    DATA(check_objects_descriptor) = CAST cl_abap_structdescr( cl_abap_typedescr=>describe_by_data( constants-checked_object_types ) ).
    LOOP AT check_objects_descriptor->get_components(  ) INTO DATA(checked_object_descriptor).
      ASSIGN COMPONENT checked_object_descriptor-name OF STRUCTURE constants-checked_object_types TO FIELD-SYMBOL(<check_object_value>).
          INSERT VALUE #( name  = checked_object_descriptor-name
                          kind  = if_ci_atc_check_meta_data=>attribute_kinds-table
                          value = NEW string_table( ) ) INTO TABLE prefixes.
    ENDLOOP.
  ENDMETHOD.


  METHOD if_ci_atc_check~get_meta_data.
    meta_data = NEW meta_data( prefixes ).
  ENDMETHOD.


  METHOD if_ci_atc_check~run.
    DATA(check_objects_descriptor) = CAST cl_abap_structdescr( cl_abap_typedescr=>describe_by_data( constants-checked_object_types ) ).
    DATA: object_prefixes TYPE TABLE OF string.
    LOOP AT check_objects_descriptor->get_components(  ) INTO DATA(checked_object_descriptor).
      ASSIGN COMPONENT checked_object_descriptor-name OF STRUCTURE constants-checked_object_types TO FIELD-SYMBOL(<check_object_value>).
      IF <check_object_value> = object-type.
        object_prefixes = prefixes[ name = checked_object_descriptor-name ]-value->*.
        EXIT.
      ENDIF.
    ENDLOOP.

    DATA: possible_prefixes TYPE string.
    LOOP AT object_prefixes INTO DATA(prefix).
      IF object-name CP prefix.
        RETURN. "Valid prefix used.
      ENDIF.

      IF sy-tabix = 1.
        possible_prefixes = prefix.
      ELSE.
        possible_prefixes = |{ possible_prefixes } or { prefix }|.
      ENDIF.
    ENDLOOP.

    "If we get here, no valid prefixes were used.
    INSERT VALUE #( code       = 'DDIC'
                      location   = VALUE #( object = object )
                      parameters = VALUE #( param_1 = object-name
                                            param_2 = possible_prefixes ) ) INTO TABLE findings.
  ENDMETHOD.


  METHOD if_ci_atc_check~set_assistant_factory.
    assistant_factory = factory.
  ENDMETHOD.


  METHOD if_ci_atc_check~set_attributes ##NEEDED.
    prefixes = attributes.
  ENDMETHOD.


  METHOD if_ci_atc_check~verify_prerequisites ##NEEDED.

  ENDMETHOD.
ENDCLASS.
