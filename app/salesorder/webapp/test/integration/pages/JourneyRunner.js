sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"salesorder/test/integration/pages/SalesOrderApprovalList",
	"salesorder/test/integration/pages/SalesOrderApprovalObjectPage"
], function (JourneyRunner, SalesOrderApprovalList, SalesOrderApprovalObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('salesorder') + '/test/flp.html#app-preview',
        pages: {
			onTheSalesOrderApprovalList: SalesOrderApprovalList,
			onTheSalesOrderApprovalObjectPage: SalesOrderApprovalObjectPage
        },
        async: true
    });

    return runner;
});

