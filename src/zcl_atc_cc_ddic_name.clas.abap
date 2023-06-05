CLASS zcl_atc_cc_ddic_name DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

PUBLIC SECTION.
  INTERFACES if_ci_atc_check.

    METHODS:
        constructor.
PROTECTED SECTION.
PRIVATE SECTION.
  DATA assistant_factory TYPE REF TO cl_ci_atc_assistant_factory.

  DATA:
    prefixes TYPE if_ci_atc_check_meta_data=>ty_attributes.
ENDCLASS.



CLASS ZCL_ATC_CC_DDIC_NAME IMPLEMENTATION.


  METHOD constructor.
    prefixes = VALUE #( ( name = 'DOMA'
                          kind = if_ci_atc_check_meta_data=>attribute_kinds-elementary
                          value = new string( ) )
                        ( name = 'DTEL'
                          kind = if_ci_atc_check_meta_data=>attribute_kinds-elementary
                          value = new string( ) ) ).
  ENDMETHOD.


  METHOD if_ci_atc_check~get_meta_data.
    meta_data = NEW meta_data( prefixes ).
  ENDMETHOD.


  METHOD if_ci_atc_check~run.
    DATA(prefix) = prefixes[ name = object-type ]-value.
    CHECK prefix IS NOT INITIAL.
    CHECK object-name NP prefix->*.
    INSERT VALUE #( code       = 'DDIC'
                    location   = VALUE #( object = object )
                    parameters = VALUE #( param_1 = object-name
                                          param_2 = prefix->* ) ) INTO TABLE findings.
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
