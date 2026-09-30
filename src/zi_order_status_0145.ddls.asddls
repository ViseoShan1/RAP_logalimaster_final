@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Order status view'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_ORDER_STATUS_0145 as select from zordstatus_0145
{
    key status as Status,
    description as Description
}
