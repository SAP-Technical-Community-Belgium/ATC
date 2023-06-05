CLASS meta_data DEFINITION FINAL.
PUBLIC SECTION.
  INTERFACES if_ci_atc_check_meta_data.

  METHODS constructor IMPORTING prefixes TYPE if_ci_atc_check_meta_data=>ty_attributes.

  DATA:
    prefixes TYPE if_ci_atc_check_meta_data=>ty_attributes.

ENDCLASS.

CLASS meta_data IMPLEMENTATION.

  METHOD if_ci_atc_check_meta_data~get_attributes ##NEEDED.
    attributes = prefixes.
  ENDMETHOD.

  METHOD if_ci_atc_check_meta_data~get_checked_object_types.
    types = VALUE #( ( zcl_atc_cc_ddic_name=>constants-checked_object_types-access_control )
                     ( zcl_atc_cc_ddic_name=>constants-checked_object_types-cds )
                     ( zcl_atc_cc_ddic_name=>constants-checked_object_types-class )
                     ( zcl_atc_cc_ddic_name=>constants-checked_object_types-data_element )
                     ( zcl_atc_cc_ddic_name=>constants-checked_object_types-domain )
                     ( zcl_atc_cc_ddic_name=>constants-checked_object_types-function_group )
                     ( zcl_atc_cc_ddic_name=>constants-checked_object_types-interface )
                     ( zcl_atc_cc_ddic_name=>constants-checked_object_types-message_class )
                     ( zcl_atc_cc_ddic_name=>constants-checked_object_types-structure )
                     ( zcl_atc_cc_ddic_name=>constants-checked_object_types-table_type ) ).
  ENDMETHOD.

  METHOD if_ci_atc_check_meta_data~get_description.
    description = |Check naming convention of DDIC objects|.
  ENDMETHOD.

  METHOD if_ci_atc_check_meta_data~get_finding_code_infos.
    finding_code_infos = VALUE #( ( code     = `DDIC`
                                    severity = if_ci_atc_check=>finding_severities-error
                                    category = if_ci_atc_check_meta_data=>finding_categories-failure_for_object
                                    text     = |Object &1 does not match any valid prefixes: &2| ) ).
  ENDMETHOD.

  METHOD if_ci_atc_check_meta_data~uses_checksums.
    uses_checksums = abap_false.
  ENDMETHOD.

  METHOD constructor.
    me->prefixes = prefixes.
  ENDMETHOD.

  METHOD if_ci_atc_check_meta_data~get_quickfix_code_infos.

  ENDMETHOD.

  METHOD if_ci_atc_check_meta_data~is_remote_enabled.
    is_remote_enabled = abap_true.
  ENDMETHOD.

ENDCLASS.
