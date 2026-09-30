@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Proj.View for order status description'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZC_ORDER_STATUS_0145 
    provider contract transactional_query
    as projection on ZI_ORDER_STATUS_0145
{
    key Status,
    Description
}
