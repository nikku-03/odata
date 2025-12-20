// using CatalogService as service from '../../srv/service';

// annotate service.Orders with @(
//     UI.FieldGroup #GeneratedGroup : {
//         $Type : 'UI.FieldGroupType',
//         Data : [
//             {
//                 $Type : 'UI.DataField',
//                 Label : 'ID',
//                 Value : ID,
//             },
//             {
//                 $Type : 'UI.DataField',
//                 Label : 'orderNo',
//                 Value : orderNo,
//             },
//             {
//                 $Type : 'UI.DataField',
//                 Label : 'salesOrderNo',
//                 Value : salesOrderNo,
//             },
//             {
//                 $Type : 'UI.DataField',
//                 Label : 'status',
//                 Value : status,
//             },
//             {
//                 $Type : 'UI.DataField',
//                 Label : 'totalAmount',
//                 Value : totalAmount,
//             },
//             {
//                 $Type : 'UI.DataField',
//                 Label : 'customer_ID',
//                 Value : customer_ID,
//             },
//         ],
//     },
//     // FIX: Moved this outside the GeneratedGroup
//     UI.FieldGroup #SalesOrderData : {
//         $Type : 'UI.FieldGroupType',
//         Data : [
//             {
//                 $Type : 'UI.DataField',
//                 Label : 'Sales Order Type',
//                 Value : salesOrder.SalesOrderType,
//             },
//             {
//                 $Type : 'UI.DataField',
//                 Label : 'Sales Organization',
//                 Value : salesOrder.SalesOrganization,
//             },
//             {
//                 $Type : 'UI.DataField',
//                 Label : 'Sold To Party',
//                 Value : salesOrder.SoldToParty,
//             },
//             {
//                 $Type : 'UI.DataField',
//                 Label : 'Distribution Channel',
//                 Value : salesOrder.DistributionChannel,
//             },
//             {
//                 $Type : 'UI.DataField',
//                 Label : 'Customer PO',
//                 Value : salesOrder.PurchaseOrderByCustomer,
//             },
//         ],
//     },
//     UI.Facets : [
//         {
//             $Type : 'UI.ReferenceFacet',
//             ID : 'GeneralFacet1',
//             Label : 'General Information',
//             Target : '@UI.FieldGroup#GeneratedGroup',
//         },
//         {
//             $Type : 'UI.ReferenceFacet',
//             ID : 'SalesOrderFacet',
//             Label : 'ODATA DETAILS : API_SALES_ORDER',
//             Target : '@UI.FieldGroup#SalesOrderData',
//         }
//     ],
//     UI.LineItem : [
//         {
//             $Type : 'UI.DataField',
//             Label : 'ID',
//             Value : ID,
//         },
//         {
//             $Type : 'UI.DataField',
//             Label : 'orderNo',
//             Value : orderNo,
//         },
//         {
//             $Type : 'UI.DataField',
//             Label : 'salesOrderNo',
//             Value : salesOrderNo,
//         },
//         {
//             $Type : 'UI.DataField',
//             Label : 'status',
//             Value : status,
//         },
//         {
//             $Type : 'UI.DataField',
//             Label : 'totalAmount',
//             Value : totalAmount,
//         },
//         {
//             $Type : 'UI.DataFieldForAction',
//             Action : 'CatalogService.acceptOrder',
//             Label : 'acceptOrder',
//         },
//         {
//             $Type : 'UI.DataFieldForAction',
//             Action : 'CatalogService.rejectOrder',
//             Label : 'rejectOrder',
//         },
//         {
//             $Type : 'UI.DataFieldForAction',
//             Action : 'CatalogService.Accept',
//             Label : 'Accept',
//             Inline : true,
//         },
//         {
//             $Type : 'UI.DataFieldForAction',
//             Action : 'CatalogService.Reject',
//             Label : 'Reject',
//             Inline : true,
//         },
//     ],
// );

// annotate service.Orders with {
//     customer @Common.ValueList : {
//         $Type : 'Common.ValueListType',
//         CollectionPath : 'Customers',
//         Parameters : [
//             {
//                 $Type : 'Common.ValueListParameterInOut',
//                 LocalDataProperty : customer_ID,
//                 ValueListProperty : 'ID',
//             },
//             {
//                 $Type : 'Common.ValueListParameterDisplayOnly',
//                 ValueListProperty : 'name',
//             },
//             {
//                 $Type : 'Common.ValueListParameterDisplayOnly',
//                 ValueListProperty : 'email',
//             },
//         ],
//     }
// }; 


using CatalogService as service from '../../srv/service';

annotate service.Orders with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'ID',
                Value : ID,
            },
            {
                $Type : 'UI.DataField',
                Label : 'orderNo',
                Value : orderNo,
            },
            {
                $Type : 'UI.DataField',
                Label : 'salesOrderNo',
                Value : salesOrderNo,
            },
            {
                $Type : 'UI.DataField',
                Label : 'status',
                Value : status,
            },
            {
                $Type : 'UI.DataField',
                Label : 'totalAmount',
                Value : totalAmount,
            },
            {
                $Type : 'UI.DataField',
                Label : 'customer_ID',
                Value : customer_ID,
            },
        ],
    },
    // FIX: Moved this outside the GeneratedGroup
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
            ID : 'GeneralFacet1',
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
            Label : 'ID',
            Value : ID,
        },
        {
            $Type : 'UI.DataField',
            Label : 'orderNo',
            Value : orderNo,
        },
        {
            $Type : 'UI.DataField',
            Label : 'salesOrderNo',
            Value : salesOrderNo,
        },
        {
            $Type : 'UI.DataField',
            Label : 'status',
            Value : status,
        },
        {
            $Type : 'UI.DataField',
            Label : 'totalAmount',
            Value : totalAmount,
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'CatalogService.acceptOrder',
            Label : 'acceptOrder',
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'CatalogService.rejectOrder',
            Label : 'rejectOrder',
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'CatalogService.Accept',
            Label : 'Accept',
            Inline : true,
            ![@UI.Hidden] : {$edmJson: {$Not: [{$Path: '@$user.roles/Manager'}, null]}}
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'CatalogService.Reject',
            Label : 'Reject',
            Inline : true,
            ![@UI.Hidden] : {$edmJson: {$Not: [{$Path: '@$user.roles/Manager'}, null]}}
        },
    ],
);

annotate service.Orders with {
    customer @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'Customers',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : customer_ID,
                ValueListProperty : 'ID',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'name',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'email',
            },
        ],
    }
};