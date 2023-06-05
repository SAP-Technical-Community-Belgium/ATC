@AbapCatalog.sqlViewName: 'ZBADSQLVIEWNAME'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Example of a bad cds view name'
define view ZBAD_CDS_VIEW_NAME as select from ekko
{
   abgru 
}
