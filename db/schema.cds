namespace salesorder.db;
using {managed} from '@sap/cds/common';

type Status: String enum {
 Approved;
 Reject;
}


entity SalesOrderApproval: managed {
    key ID: UUID;
    salesOrderID: String;
    salesOrg: Integer;
    soldToParty: String;
    netValue: Integer;
    currency : String;
    approvalStatus: Status;
    approvalComment: String;
    createdBy: String;
    createdAt: Integer;
}