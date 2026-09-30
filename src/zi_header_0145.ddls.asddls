@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Header view entity'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_HEADER_0145
  as select from zheader_0145
  composition [0..*] of ZI_ITEMS_0145        as _Items
  association [0..1] to ZC_ORDER_STATUS_0145 as _OrderStatus on $projection.Orderstatus = _OrderStatus.Status
{
  key id                                         as Id,
      email                                      as Email,
      firstname                                  as Firstname,
      lastname                                   as Lastname,
      concat_with_space( firstname, lastname, 1) as CustomerFullName,
      country                                    as Country,
      createon                                   as Createon,
      deliverydate                               as Deliverydate,
      orderstatus                                as Orderstatus,
      imageurl                                   as Imageurl,
      local_created_by                           as LocalCreatedBy,
      local_created_at                           as LocalCreatedAt,
      local_last_changed_by                      as LocalLastChangedBy,
      local_last_changed_at                      as LocalLastChangeAt,
      last_changed_at                            as LastChangeAt,
      _Items,
      _OrderStatus
}
