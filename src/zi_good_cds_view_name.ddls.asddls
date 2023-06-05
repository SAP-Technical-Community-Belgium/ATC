@AbapCatalog.sqlViewName: 'ZIGOODSQLVNAME'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Example of a good cds view name'
define view ZI_Good_cds_view_name as select from ekko
{
    abgru
}
