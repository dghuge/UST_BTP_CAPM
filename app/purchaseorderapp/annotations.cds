using CatalogService as service from '../../srv/CatalogService';

annotate service.POSet with @(
    Common.DefaultValuesFunction : 'getDefaultPO',
    UI.SelectionFields:[
        PO_ID,
        PARTNER_GUID.COMPANY_NAME,
        GROSS_AMOUNT,
        OVERALL_STATUS
    ],
    UI.LineItem:[
        {
            $Type : 'UI.DataField',
            Value : PO_ID
        },
        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID.COMPANY_NAME
        },
        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID.ADDRESS_GUID.COUNTRY
        },
        {
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT
        },
        {
            $Type : 'UI.DataField',
            Value : CURRENCY_code
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action: 'CatalogService.boost',
            Label: 'Boost',
            Inline: true,
        },
        {
            $Type : 'UI.DataField',
            Value : OverallStatus,
            Criticality: ColorCode
        }
    ],
    UI.HeaderInfo:{
        TypeName: 'Purchase Order',
        TypeNamePlural: 'Purchase Orders',
        Title: {Value: PO_ID},
        Description:{Value:PARTNER_GUID.COMPANY_NAME}
    },
    UI.Facets:[
        {
            $Type: 'UI.CollectionFacet',
            Label: 'General Information',
            Facets:[
                {
                    $Type: 'UI.ReferenceFacet',
                    Label: 'Order Details',
                    Target:'@UI.Identification'
                },
                {
                    $Type: 'UI.ReferenceFacet',
                    Label: 'Configuration Details',
                    Target:'@UI.FieldGroup#Deepak'
                }
            ]
        },
        {
            $Type:'UI.ReferenceFacet',
            Label:'PO Items',
            Target:'Items/@UI.LineItem'
        }
    ],
    UI.Identification:[
        {
            $Type: 'UI.DataField',
            Value: PO_ID
        },
        {
            $Type: 'UI.DataField',
            Value: PARTNER_GUID_NODE_KEY
        },
        {
            $Type: 'UI.DataField',
            Value: OVERALL_STATUS,
        }
    ],
    UI.FieldGroup #Deepak:{
        Label:'PO Pricing',
        Data:[
            {
                $Type: 'UI.DataField',
                Value: GROSS_AMOUNT
            },
            {
                $Type: 'UI.DataField',
                Value: NET_AMOUNT
            },
            {
                $Type: 'UI.DataField',
                Value: TAX_AMOUNT
            },
            {
                $Type: 'UI.DataField',
                Value: CURRENCY_code
            }
        ]
    }
) ;

annotate service.POItemSet with @(
    UI.LineItem:[
        {
            $Type: 'UI.DataField',
            Value: PO_ITEM_POS
        },
        {
            $Type: 'UI.DataField',
            Value: GROSS_AMOUNT
        },
        {
            $Type: 'UI.DataField',
            Value: CURRENCY_code
        },
        {
            $Type: 'UI.DataField',
            Value: PRODUCT_GUID.CATEGORY
        }
    ],
    UI.HeaderInfo:{
        TypeName: 'Purchase Order Item',
        TypeNamePlural: 'Purchase Orders Items',
        Title: {Value: PO_ITEM_POS},
        Description:{Value:PRODUCT_GUID.DESCRIPTION}
    },
    UI.Facets:[
        {
            $Type:'UI.ReferenceFacet',
            Label:'Item Details',
            Target:'@UI.Identification'
        },
    ],
    UI.Identification:[
        {
            $Type: 'UI.DataField',
            Value: PO_ITEM_POS
        },
        {
            $Type: 'UI.DataField',
            Value: PRODUCT_GUID_NODE_KEY
        },
        {
            $Type: 'UI.DataField',
            Value: NET_AMOUNT
        },
        {
            $Type: 'UI.DataField',
            Value: GROSS_AMOUNT
        },
        {
            $Type: 'UI.DataField',
            Value: TAX_AMOUNT
        },
        {
            $Type: 'UI.DataField',
            Value: CURRENCY_code
        },
    ]
);

annotate service.POSet with {
    PARTNER_GUID@(
        Common : {
            Text : PARTNER_GUID.COMPANY_NAME,
        },
        ValueList.entity: CatalogService.BusinessPartnerSet
    );
    OVERALL_STATUS@(
        readonly
    )
} ;

annotate service.POItemSet with {
    PRODUCT_GUID@(
        Common : {
            Text : PRODUCT_GUID.DESCRIPTION,
        },
        ValueList.entity: CatalogService.Productset
    )
} ;


@cds.odata.valuelist
annotate service.BusinessPartnerSet with @(
    UI.Identification:[
        {
            $Type: 'UI.DataField',
            Value: COMPANY_NAME
        }
    ]
);

@cds.odata.valuelist
annotate service.ProductSet with @(
    UI.Identification:[
        {
            $Type: 'UI.DataField',
            Value: DESCRIPTION
        }
    ]
);


