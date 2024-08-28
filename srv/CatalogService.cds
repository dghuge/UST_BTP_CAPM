using { anubhav.db.master, anubhav.db.transaction  } from '../db/datamodel';
using { cappo.cds } from '../db/CDSViews';


service CatalogService @(path:'CatalogService', requires: 'authenticated-user') {

    //@readonly
    entity EmployeeSet @(restrict: [ 
                        { grant: ['READ'], to: 'Viewer', where: 'bankName = $user.BankName' },
                        { grant: ['WRITE'], to: 'Admin' }
                        ]) as projection on master.employees;
    entity ProductSet as projection on master.product;
    entity BusinessPartnerSet as projection on master.businesspartner;
    entity BusinessAddressSet as projection on master.address;
    // @Capabilities : { Deletable:false }
    entity POSet @(odata.draft.enabled:true) as projection on transaction.purchaseorder{
        *,
        Items,
        case OVERALL_STATUS
            when 'P' then 'Pending'
            when 'A' then 'Approved'
            when 'N' then 'New'
            when 'X' then 'Rejected'
        end as OverallStatus: String(10),
        case OVERALL_STATUS
            when 'P' then 2
            when 'A' then 3
            when 'N' then 2
            when 'X' then 1
        end as ColorCode: Integer
    }
    actions{
        //This will refresh the list and display the updated data on action
        @Common.SideEffects :{
            TargetProperties:[
                'in/GROSS_AMOUNT'
            ]
        }
        action boost() returns POSet
    };
    function largestOrder() returns POSet;
    function getDefaultPO() returns POSet;
    // function largestOrder() returns array of POSet;              //For multiple items
    entity POItemSet as projection on transaction.poitems;
    // entity OrderItems as projection on cds.CDSViews.ItemView;
    // entity Products as projection on cds.CDSViews.ProductView;

}