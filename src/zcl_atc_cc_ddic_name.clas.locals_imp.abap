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
    types = VALUE #( ( 'INTF' ) ( 'FUGR' ) ( 'CLAS' )
                     ( 'TABL' ) ( 'DTEL' ) ( 'DOMA' )
                     ( 'TTYP' ) ( 'DDLS' ) ( 'DCLS' )
                     ( 'FUNC' ) ( 'MSAG' ) ).
  ENDMETHOD.

  METHOD if_ci_atc_check_meta_data~get_description.
    description = |Check naming convention of DDIC objects|.
  ENDMETHOD.

  METHOD if_ci_atc_check_meta_data~get_finding_code_infos.
    finding_code_infos = VALUE #( ( code     = `DDIC`
                                    severity = if_ci_atc_check=>finding_severities-error
                                    category = if_ci_atc_check_meta_data=>finding_categories-failure_for_object
                                    text     = |Object &1 does not match prefix pattern &2| ) ).
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
