CLASS zcl_preload_data_0145 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

    TYPES: BEGIN OF typ_s_status,
            status TYPE zheader_0145-orderstatus,
           END OF typ_s_status,
           typ_t_status TYPE STANDARD TABLE OF typ_s_status
                           WITH NON-UNIQUE DEFAULT KEY,
           typ_t_zordstatus_0145 TYPE STANDARD TABLE OF zordstatus_0145,
           BEGIN OF typ_s_items,
             name TYPE zde_name_0145,
             description TYPE zde_description_0145,
             price TYPE zde_price_0145,
             waers TYPE waers,
             height TYPE zde_height_0145,
             width TYPE zde_width_0145,
             depth TYPE zde_depth_0145,
             dimensions_uom TYPE meins,
             unitofmeasure TYPE meins,
           END OF typ_s_items,
           typ_t_items TYPE STANDARD TABLE OF typ_s_items
                            WITH NON-UNIQUE DEFAULT KEY.

  PROTECTED SECTION.


     CLASS-METHODS: get_order_status
       EXPORTING
         st_status       TYPE typ_t_status
         st_status_descr TYPE typ_t_zordstatus_0145,
       get_items
         RETURNING VALUE(rt_items) TYPE typ_t_items.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_preload_data_0145 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.


    DATA: lt_header       TYPE STANDARD TABLE OF zheader_0145,
          lt_items        TYPE STANDARD TABLE OF zitems_0145,
          lt_status_descr TYPE STANDARD TABLE OF zordstatus_0145,
          lt_order_status TYPE typ_t_status,
          lv_count_header TYPE i,
          lv_count_item   TYPE i,
          lv_id_header TYPE zheader_0145-id,
          lv_id_item TYPE zitems_0145-item_uuid,
          lv_quantity TYPE i.

    get_order_status(
        IMPORTING
        st_status = lt_order_status
        st_status_descr = lt_status_descr
    ).
    DATA(lt_items_random) = get_items( ).

    out->write( 'Deleting previous data' ).

    DELETE FROM zheader_0145.
    DELETE FROM zitems_0145.
    DELETE FROM zordstatus_0145.

    DATA(lo_rand) = cl_abap_random=>create( ).

    lv_count_header = 1.
    DO 30 TIMES.
      FINAL(lv_total_items) = lo_rand->intinrange( low = 1 high = 4 ).
      lv_id_header = |{ lv_count_header }|.

        DATA(lv_items_status) = lines(  lt_order_status ).
        DATA(lv_num) = lo_rand->intinrange( low = 1 high = lv_items_status ).
        READ TABLE lt_order_status INTO DATA(ls_order_status) INDEX lv_num.


      lt_header = VALUE #( BASE lt_header (
        id = |{ lv_id_header }|
        email = 'aitor.martin@viseo.com'
        firstname = 'Aitor'
        lastname = 'Martin'
        country = 'Spain'
        local_created_by = |{ cl_abap_context_info=>get_user_technical_name( ) }|
        createon = |{ cl_abap_context_info=>get_system_date( ) }|
        deliverydate = |{ cl_abap_context_info=>get_system_date( ) }|
        orderstatus = |{ ls_order_status-status }|
        imageurl = ''
      ) ).

    lv_count_item = 1.
     DO lv_total_items TIMES.
        DATA(lv_num_random_item) = lo_rand->intinrange( low = 1 high = lines(  lt_items_random ) ).
        READ TABLE lt_items_random INTO DATA(ls_item_random) INDEX lv_num_random_item.

        lv_id_item = |{ lv_count_header }:{ lv_count_item }|.
        lv_quantity = lo_rand->intinrange( low = 1 high = 6 ).
        lt_items = VALUE  #(  BASE lt_items (
          id = |{ lv_id_header }|
          item_uuid = |{ lv_id_item }|
          name = ls_item_random-name
          description = ls_item_random-description
          releasedate = |{ cl_abap_context_info=>get_system_date( ) }|
          price = ls_item_random-price * lv_quantity
          waers = ls_item_random-waers
          height = ls_item_random-height
          width = ls_item_random-width
          depth = ls_item_random-depth
          dimensions_uom = ls_item_random-dimensions_uom
          quantity = lv_quantity
          unitofmeasure = ls_item_random-unitofmeasure
        ) ).
    lv_count_item = lv_count_item + 1.

     ENDDO.

      lv_count_header = lv_count_header + 1.
    ENDDO.

    INSERT zheader_0145 FROM TABLE @lt_header.
    INSERT zitems_0145 FROM TABLE @lt_items.
    INSERT zordstatus_0145 FROM TABLE @lt_status_descr.

  ENDMETHOD.

  method get_order_status.
    st_status = VALUE #( ( status = 1 )  ( status = 2 )
        ( status = 3 )  ( status = 4 ) ( status = 5 )
    ).

    st_status_descr = VALUE #( ( status = 1 description = 'New' )
                               ( status = 2 description = 'Processing' )
                               ( status = 3 description = 'Shipped' )
                               ( status = 4 description = 'Received' ) ( status = 5 description = 'Cancelled' )
    ).
  ENDMETHOD.

  METHOD get_items.
 rt_items = VALUE #(
        (
           name = 'Bimble Classic Small' description = 'Hoptimist Bimble Red Small' price = 25
           waers = 'EUR' height = 7 width = 5 depth = 5 dimensions_uom = 'CM'
           unitofmeasure = 'ST'
        )
        (
           name = 'Bumble Classic Large' description = 'Hoptimist Bumble Yellow Large' price = 38
           waers = 'EUR' height = 13 width = 10 depth = 10 dimensions_uom = 'CM'
           unitofmeasure = 'ST'
        )
        (
           name = 'Baby Bimble Oak' description = 'Hoptimist Bimble Wooden Oak Small' price = 45
           waers = 'EUR' height = 7 width = 5 depth = 5 dimensions_uom = 'CM'
           unitofmeasure = 'ST'
        )
        (
           name = 'Junior Bumble Oak' description = 'Hoptimist Bumble Wooden Oak Large' price = 65
           waers = 'EUR' height = 13 width = 10 depth = 10 dimensions_uom = 'CM'
           unitofmeasure = 'ST'
        )
        (
           name = 'Bimble Chrome Medium' description = 'Hoptimist Bimble Metallic Shiny Chrome' price = 32
           waers = 'EUR' height = 10 width = 7 depth = 7 dimensions_uom = 'CM'
           unitofmeasure = 'ST'
        )
        (
           name = 'Bumble Shiny Brass' description = 'Hoptimist Bumble Brass Edition' price = 35
           waers = 'EUR' height = 10 width = 7 depth = 7 dimensions_uom = 'CM'
           unitofmeasure = 'ST'
        )
        (
           name = 'Bird Small White' description = 'Hoptimist Bird Spring Figure White' price = 22
           waers = 'EUR' height = 7 width = 6 depth = 6 dimensions_uom = 'CM'
           unitofmeasure = 'ST'
        )
        (
           name = 'Bimble Soft Dusty Rose' description = 'Hoptimist Soft Collection Pink' price = 28
           waers = 'EUR' height = 10 width = 7 depth = 7 dimensions_uom = 'CM'
           unitofmeasure = 'ST'
        )
    ).
  ENDMETHOD.

ENDCLASS.
