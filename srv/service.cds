// using { ust.nikita as db } from '../db/schema';
// using { ZAPI_SALES_ORDER_SRV } from './external/ZAPI_SALES_ORDER_SRV';

// service CatalogService@(requires: 'authenticated-user')  {
//    // Expose the external entity first
//    @readonly
//    entity A_SalesOrder as projection on ZAPI_SALES_ORDER_SRV.A_SalesOrder {
//      key SalesOrder,
//      SalesOrderType,
//      SalesOrganization,
//      DistributionChannel,
//      OrganizationDivision,
//      SoldToParty,
//      PurchaseOrderByCustomer
//    };
   
//    @odata.draft.enabled
//    @(restrict: [
//      { grant: ['READ'], to: 'Employee' },
//      { grant: ['*'], to: 'Manager' }
//    ])
//    entity Orders as projection on db.Orders {
//         key ID,
//         orderNo,
//         salesOrderNo,
//         status,
//         totalAmount,
//         customer,
//         items,
//         salesOrder : Association to A_SalesOrder on salesOrder.SalesOrder = salesOrderNo
//     }actions {
//       @(requires: 'Manager')
//     action Accept() returns Orders;
//      @(requires: 'Manager')
//     action Reject() returns Orders;};

//    entity Customers as projection on db.Customers;
   
//    entity OrderItems as projection on db.OrderItems;
// }


using { ust.nikita as db } from '../db/schema';
using { ZAPI_SALES_ORDER_SRV } from './external/ZAPI_SALES_ORDER_SRV';

service CatalogService @(requires: 'authenticated-user') {
   // Expose the external entity first
   @readonly
   entity A_SalesOrder as projection on ZAPI_SALES_ORDER_SRV.A_SalesOrder {
     key SalesOrder,
     SalesOrderType,
     SalesOrganization,
     DistributionChannel,
     OrganizationDivision,
     SoldToParty,
     PurchaseOrderByCustomer
   };
   
   @odata.draft.enabled
   @(restrict: [
     { grant: ['READ'], to: 'Employee' },
     { grant: ['*'], to: 'Manager' }
   ])
   entity Orders as projection on db.Orders {
        key ID,
        orderNo,
        salesOrderNo,
        status,
        totalAmount,
        customer,
        createdBy,
        items,
        salesOrder : Association to A_SalesOrder on salesOrder.SalesOrder = salesOrderNo
    } actions {
      // Hide actions from Employees/Customers - only Managers can see
      @(
        requires: 'Manager',
        Common.SideEffects.TargetEntities: [Orders]
      )
      action Accept() returns Orders;
      
      @(
        requires: 'Manager',
        Common.SideEffects.TargetEntities: [Orders]
      )
      action Reject() returns Orders;
    };

   entity Customers as projection on db.Customers;
   
   entity OrderItems as projection on db.OrderItems;
}