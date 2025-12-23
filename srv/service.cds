
using { salesorder.db as db } from '../db/schema';
using { ZAPI_SALES_ORDER_SRV } from './external/ZAPI_SALES_ORDER_SRV';

service CatalogService @(requires: 'authenticated-user') {
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
   entity SalesOrderApproval as projection on db.SalesOrderApproval{
        key ID,
        salesOrderID,
        salesOrg,
        soldToParty,
        netValue,
        currency ,
        approvalStatus,
        approvalComment,
        createdBy,
        createdAt,
        salesorder: Association to A_SalesOrder on salesorder.SalesOrder= salesOrderID,
}actions{
    action approveSalesOrder() ;
    action rejectSalesOrder();

}
}