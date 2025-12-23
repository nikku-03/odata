const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () {
    const { SalesOrderApproval } = this.entities;
    const ext = await cds.connect.to('ZAPI_SALES_ORDER_SRV');

    this.after('READ', SalesOrderApproval, async (salesOrders) => {
        if (!salesOrders) return;

        const records = Array.isArray(salesOrders) ? salesOrders : [salesOrders];

        await Promise.all(records.map(async (so) => {
            if (so.salesOrderID) {
                so.salesorder = await ext.run(
                    SELECT.one.from('A_SalesOrder').where({ SalesOrder: so.salesOrderID })
                ).catch(err => console.error(err));
            }
        }));

        return salesOrders;
    });
});
