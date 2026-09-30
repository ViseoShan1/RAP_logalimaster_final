@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root view header'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_HEADER_0145
  provider contract transactional_query
  as projection on ZI_HEADER_0145
{
  key Id,
      Email,
      Firstname,
      Lastname,
      CustomerFullName,
      Country,
      Createon,
      Deliverydate,
      @ObjectModel.text.element: ['OrderStatusDescr']
      @Consumption.valueHelpDefinition: [{
          entity: { name: 'ZC_ORDER_STATUS_0145', element: 'Status' }
      }]
      Orderstatus,
      Imageurl,

      LocalCreatedBy,
      LocalCreatedAt,
      LocalLastChangedBy,
      LocalLastChangeAt,
      LastChangeAt,
      _OrderStatus.Description as OrderStatusDescr,
      /* Associations */
      _Items : redirected to composition child zc_items_0145,
      _OrderStatus
}
