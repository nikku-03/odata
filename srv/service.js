// const cds = require('@sap/cds');

// module.exports = cds.service.impl(async function () {
//   const { Orders } = this.entities;
//   const ext = await cds.connect.to('ZAPI_SALES_ORDER_SRV');

//   this.on('READ', Orders, async (req, next) => {
//     const orders = await next();
//     if (!orders) return orders;

//     await Promise.all(
//       (Array.isArray(orders) ? orders : [orders])
//         .map(async o => o.salesOrderNo && (o.salesOrder = await ext.run(
//           SELECT.one.from('ZAPI_SALES_ORDER_SRV.A_SalesOrder').where({ SalesOrder: o.salesOrderNo })
//         ).catch(e => console.error(e))))
//     );

//     return orders;
//   });
// });

// const cds = require('@sap/cds');

// module.exports = cds.service.impl(async function () {
//   const { Orders } = this.entities;
//   const ext = await cds.connect.to('ZAPI_SALES_ORDER_SRV');

//   /* ================= EXISTING LOGIC (ENHANCED) ================= */

//   this.on('READ', Orders, async (req, next) => {
//     const orders = await next();
//     if (!orders) return orders;

//     await Promise.all(
//       (Array.isArray(orders) ? orders : [orders])
//         .map(async o =>
//           o.salesOrderNo &&
//           (o.salesOrder = await ext
//             .run(
//               SELECT.one
//                 .from('ZAPI_SALES_ORDER_SRV.A_SalesOrder')
//                 .where({ SalesOrder: o.salesOrderNo })
//             )
//             .catch(e => console.error(e)))
//         )
//     );

//     return orders;
//   });

//   /* ================= CREATE - SET CREATED BY ================= */
  
//   this.before('CREATE', Orders, async (req) => {
//     // Automatically set createdBy to current user
//     req.data.createdBy = req.user.id;
//     req.data.status = req.data.status || 'PENDING';
//   });

//   /* ================= ACCEPT ACTION ================= */

//   this.on('Accept', Orders, async (req) => {
//     const { ID } = req.params[0];

//     // Check if user has Manager role
//     if (!req.user.is('Manager')) {
//       req.reject(403, 'Only managers can accept orders');
//     }

//     // Get the order
//     const order = await SELECT.one.from(Orders).where({ ID });
    
//     if (!order) {
//       req.reject(404, 'Order not found');
//     }

//     if (order.status === 'ACCEPTED') {
//       req.reject(400, 'Order is already accepted');
//     }

//     // Update status to ACCEPTED
//     await UPDATE(Orders)
//       .set({ status: 'ACCEPTED' })
//       .where({ ID });

//     // POST DATA TO EXTERNAL SYSTEM
//     try {
//       const postResult = await postOrderToExternalSystem(order, ext);
//       console.log('Order posted to external system:', postResult);
      
//       // Optionally update salesOrderNo if returned from external system
//       if (postResult && postResult.SalesOrder) {
//         await UPDATE(Orders)
//           .set({ salesOrderNo: postResult.SalesOrder })
//           .where({ ID });
//       }
//     } catch (error) {
//       console.error('Failed to post order to external system:', error);
//       // Rollback status if posting fails
//       await UPDATE(Orders)
//         .set({ status: 'PENDING' })
//         .where({ ID });
//       req.reject(500, 'Failed to post order to external system: ' + error.message);
//     }

//     return SELECT.one.from(Orders).where({ ID });
//   });

//   /* ================= REJECT ACTION ================= */

//   this.on('Reject', Orders, async (req) => {
//     const { ID } = req.params[0];

//     // Check if user has Manager role
//     if (!req.user.is('Manager')) {
//       req.reject(403, 'Only managers can reject orders');
//     }

//     // Get the order
//     const order = await SELECT.one.from(Orders).where({ ID });
    
//     if (!order) {
//       req.reject(404, 'Order not found');
//     }

//     if (order.status === 'REJECTED') {
//       req.reject(400, 'Order is already rejected');
//     }

//     // Update status to REJECTED
//     await UPDATE(Orders)
//       .set({ status: 'REJECTED' })
//       .where({ ID });

//     // NO POSTING TO EXTERNAL SYSTEM FOR REJECTED ORDERS
//     console.log('Order rejected - not posted to external system');

//     return SELECT.one.from(Orders).where({ ID });
//   });

//   /* ================= POST TO EXTERNAL SYSTEM ================= */

//   async function postOrderToExternalSystem(order, extService) {
//     // Prepare the payload for external system
//     const payload = {
//       SalesOrderType: 'OR',  // Adjust based on your requirements
//       SalesOrganization: '1010',  // Adjust based on your requirements
//       DistributionChannel: '10',  // Adjust based on your requirements
//       OrganizationDivision: '00',  // Adjust based on your requirements
//       SoldToParty: order.customer_ID || order.customer,
//       PurchaseOrderByCustomer: order.orderNo,
//       // Add other required fields from your external API
//     };

//     // Post to external SAP system
//     const result = await extService.run(
//       INSERT.into('ZAPI_SALES_ORDER_SRV.A_SalesOrder').entries(payload)
//     );

//     return result;
//   }
// });
const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () {
  const { Orders } = this.entities;
  const ext = await cds.connect.to('ZAPI_SALES_ORDER_SRV');

  /* ================= READ WITH ROLE-BASED FILTERING ================= */

  this.on('READ', Orders, async (req, next) => {
    // Employee sees only their orders, Manager sees everything
    if (!req.user.is('Manager')) {
      // This is an Employee or regular user
      if (req.user.id) {
        req.query.where({ createdBy: req.user.id });
      }
    }
    // If Manager, no filtering - they see all orders
    
    const orders = await next();
    if (!orders) return orders;

    // Fetch external sales order data
    await Promise.all(
      (Array.isArray(orders) ? orders : [orders])
        .map(async o =>
          o.salesOrderNo &&
          (o.salesOrder = await ext
            .run(
              SELECT.one
                .from('ZAPI_SALES_ORDER_SRV.A_SalesOrder')
                .where({ SalesOrder: o.salesOrderNo })
            )
            .catch(e => console.error(e)))
        )
    );

    return orders;
  });

  /* ================= CREATE - SET CREATED BY ================= */
  
  this.before('CREATE', Orders, async (req) => {
    // Automatically set createdBy to current user
    req.data.createdBy = req.user.id;
    req.data.status = req.data.status || 'PENDING';
  });

  /* ================= ACCEPT ACTION ================= */

  this.on('Accept', Orders, async (req) => {
    const { ID } = req.params[0];

    // Check if user has Manager role
    if (!req.user.is('Manager')) {
      req.reject(403, 'Only managers can accept orders');
    }

    // Get the order
    const order = await SELECT.one.from(Orders).where({ ID });
    
    if (!order) {
      req.reject(404, 'Order not found');
    }

    if (order.status === 'ACCEPTED') {
      req.reject(400, 'Order is already accepted');
    }

    // Update status to ACCEPTED
    await UPDATE(Orders)
      .set({ status: 'ACCEPTED' })
      .where({ ID });

    // POST DATA TO EXTERNAL SYSTEM
    try {
      const postResult = await postOrderToExternalSystem(order, ext);
      console.log('Order posted to external system:', postResult);
      
      // Optionally update salesOrderNo if returned from external system
      if (postResult && postResult.SalesOrder) {
        await UPDATE(Orders)
          .set({ salesOrderNo: postResult.SalesOrder })
          .where({ ID });
      }
    } catch (error) {
      console.error('Failed to post order to external system:', error);
      // Rollback status if posting fails
      await UPDATE(Orders)
        .set({ status: 'PENDING' })
        .where({ ID });
      req.reject(500, 'Failed to post order to external system: ' + error.message);
    }

    return SELECT.one.from(Orders).where({ ID });
  });

  /* ================= REJECT ACTION ================= */

  this.on('Reject', Orders, async (req) => {
    const { ID } = req.params[0];

    // Check if user has Manager role
    if (!req.user.is('Manager')) {
      req.reject(403, 'Only managers can reject orders');
    }

    // Get the order
    const order = await SELECT.one.from(Orders).where({ ID });
    
    if (!order) {
      req.reject(404, 'Order not found');
    }

    if (order.status === 'REJECTED') {
      req.reject(400, 'Order is already rejected');
    }

    // Update status to REJECTED
    await UPDATE(Orders)
      .set({ status: 'REJECTED' })
      .where({ ID });

    // NO POSTING TO EXTERNAL SYSTEM FOR REJECTED ORDERS
    console.log('Order rejected - not posted to external system');

    return SELECT.one.from(Orders).where({ ID });
  });

  /* ================= POST TO EXTERNAL SYSTEM ================= */

  async function postOrderToExternalSystem(order, extService) {
    // Prepare the payload for external system
    const payload = {
      SalesOrderType: 'OR',  // Adjust based on your requirements
      SalesOrganization: '1010',  // Adjust based on your requirements
      DistributionChannel: '10',  // Adjust based on your requirements
      OrganizationDivision: '00',  // Adjust based on your requirements
      SoldToParty: order.customer_ID || order.customer,
      PurchaseOrderByCustomer: order.orderNo,
      // Add other required fields from your external API
    };

    // Post to external SAP system
    const result = await extService.run(
      INSERT.into('ZAPI_SALES_ORDER_SRV.A_SalesOrder').entries(payload)
    );

    return result;
  }
});