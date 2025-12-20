const cds = require('@sap/cds');

module.exports = async (srv) => 
{        
    // Using CDS API      
    const ZAPI_SALES_ORDER_SRV = await cds.connect.to("ZAPI_SALES_ORDER_SRV"); 
      srv.on('READ', 'A_SalesOrder', req => ZAPI_SALES_ORDER_SRV.run(req.query)); 
      srv.on('READ', 'A_SalesOrderItem', req => ZAPI_SALES_ORDER_SRV.run(req.query)); 
      srv.on('CREATE', 'A_SalesOrder', async (req) => {
    return ZAPI_SALES_ORDER_SRV.send({
      method: 'POST',
      path: 'A_SalesOrder',
      data: req.data,
      csrf: true,
      headers: {
        'X-Requested-With': 'XMLHttpRequest'
      }
    });
  });
}