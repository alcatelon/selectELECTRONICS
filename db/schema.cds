namespace com.satinfotech.selectelectronics;
using { cuid,managed } from '@sap/cds/common';
@assert.unique: {
    partnerno:[partnerno]
}
entity BusinessPartner {
    key ID: UUID;
    partnerno:String(6);
    @title:'Name'
    name:String(20);
 @title:'Address 1'
    address1:String(70);
 @title:'Address 2'
    address2:String(70);
    @title:'City'
    city:String(20);
     @title:'State'
    state:Association to States;
     @title:'pin code'
    pinCode:String(10);
    @title:' Is_gstn_registered'
     Isgstnregistered:Boolean default false;
       @title:' GSTIN number'
     Gstin:String(20);
       @title:' is vendor'
    Isvendor:Boolean default false;
      @title:' is customer'
    Iscustomer:Boolean default false;
}

entity Store {
    key ID: UUID;
    storeid :String(10);
    name         : String(100);
    address1     : String(255);
    address2     : String(255);
    city         : String(100);
    state        : Association to States;
    pincode      : String(10) @(assert.format: '^[1-9][0-9]{5}$');
}

entity Product {
    key ID: UUID;
    p_id           : String(20); 
    name            : String(100);
    imageURL        : String(255);
    costPrice       : Decimal(15, 2); 
    sellPrice       : Decimal(15, 2); 
}


entity Stock {
    key ID            : UUID;
    storeId         : Association to Store;
    productId       : Association to Product;
    stock_qty        : Integer;
}



@cds.persistence.skip
entity States : cuid,managed {
@title:'code'
key code: String(3);
@title:'description'
description:String(10);  
};

