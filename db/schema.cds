namespace ust.nikita;

using { managed } from '@sap/cds/common';

type Amount : Decimal(13,2);

entity Customers : managed {
  key ID    : String;
      name  : String;
      email : String;
}

entity Orders : managed {
  key ID           : String;
      orderNo      : String;
      salesOrderNo : String;
      status       : String;
      totalAmount  : Amount;

      customer     : Association to Customers;
      
      items        : Composition of many OrderItems
                       on items.order = $self;
}

entity OrderItems : managed {
  key ID      : String;
      order   : Association to Orders;
      product : String;
      qty     : Integer;
      price   : Amount;
}
