using CatalogService as service from '../../srv/service';

annotate service.SalesOrderApproval with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'salesOrderID',
                Value : salesOrderID,
            },
            {
                $Type : 'UI.DataField',
                Label : 'salesOrg',
                Value : salesOrg,
            },
            {
                $Type : 'UI.DataField',
                Label : 'soldToParty',
                Value : soldToParty,
            },
            {
                $Type : 'UI.DataField',
                Label : 'netValue',
                Value : netValue,
            },
            {
                $Type : 'UI.DataField',
                Label : 'currency',
                Value : currency,
            },
            {
                $Type : 'UI.DataField',
                Label : 'approvalStatus',
                Value : approvalStatus,
            },
            {
                $Type : 'UI.DataField',
                Label : 'approvalComment',
                Value : approvalComment,
            },
            {
                $Type : 'UI.DataField',
                Label : 'createdBy',
                Value : createdBy,
            },
            {
                $Type : 'UI.DataField',
                Label : 'createdAt',
                Value : createdAt,
            },
            {
                $Type : 'UI.DataFieldForAction',
                Action : 'CatalogService.approveSalesOrder',
                Label : 'Approve',
            },
            {
                $Type : 'UI.DataFieldForAction',
                Action : 'CatalogService.rejectSalesOrder',
                Label : 'Reject',
            }
        ],
    },

    UI.FieldGroup #SalesOrderData : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'Sales Order Type',
                Value : salesOrder.SalesOrderType,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Sales Organization',
                Value : salesOrder.SalesOrganization,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Sold To Party',
                Value : salesOrder.SoldToParty,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Distribution Channel',
                Value : salesOrder.DistributionChannel,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Customer PO',
                Value : salesOrder.PurchaseOrderByCustomer,
            },
        ],
    },

    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'SalesOrderFacet',
            Label : 'ODATA DETAILS : API_SALES_ORDER',
            Target : '@UI.FieldGroup#SalesOrderData',
        }
    ],

    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'salesOrderID',
            Value : salesOrderID,
        },
        {
            $Type : 'UI.DataField',
            Label : 'salesOrg',
            Value : salesOrg,
        },
        {
            $Type : 'UI.DataField',
            Label : 'soldToParty',
            Value : soldToParty,
        },
        {
            $Type : 'UI.DataField',
            Label : 'netValue',
            Value : netValue,
        },
        {
            $Type : 'UI.DataField',
            Label : 'currency',
            Value : currency,
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'CatalogService.approveSalesOrder',
            Label : 'Approve',
            Inline : true,
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'CatalogService.rejectSalesOrder',
            Label : 'Reject',
            Inline : true,
        }
    ],

    UI.SelectionFields : [
        ID,
        salesOrg,
        salesOrderID,
        soldToParty,
        netValue,
        approvalStatus,
    ]
);
