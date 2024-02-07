using {com.satinfotech.selectelectronics as db} from '../db/schema';

service selectElectronics {
    entity BusinessPartner as projection on db.BusinessPartner;
    entity States           as projection on db.States;
    entity Store           as projection on db.Store;
    entity Product         as projection on db.Product;
    entity Stock as projection on db.Stock;
}


annotate selectElectronics.BusinessPartner with @odata.draft.enabled;
annotate selectElectronics.Store with @odata.draft.enabled;
annotate selectElectronics.Product with @odata.draft.enabled;
annotate selectElectronics.Stock with @odata.draft.enabled;


annotate selectElectronics.BusinessPartner with {
    pinCode @assert.format: '^[1-9]{1}[0-9]{2}\\s{0, 1}[0-9]{3}$';
    Gstin @assert.format: '^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[0-9]{1}[Z]{1}[0-9]{1}$';
}





annotate selectElectronics.States with @(UI.LineItem: [
    {
        $Type: 'UI.DataField',
        Value: code
    },
    {
        $Type: 'UI.DataField',
        Value: description
    },
],

);

annotate selectElectronics.BusinessPartner with @(
    UI.LineItem             : [

        {
            Label: 'Bussiness Partner Id',
            Value: partnerno
        },
        {
            Label: 'Name',
            Value: name
        },
        {
            Label: 'Address 1',
            Value: address1
        },
        {
            Label: 'Address 2',
            Value: address2
        },
        {
            Label: 'City',
            Value: city
        },
        {
            Label: 'State',
            Value: state_code
        },
        {
            Label: 'Is_gstn_registered',
            Value: Isgstnregistered
        },
        {
            Label: 'GSTIN Number',
            Value: Gstin
        },
    ],
    UI.FieldGroup #BusinessP: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
            Label: 'Bussiness Partner Id',
            Value: partnerno
        },
        {
            Label: 'Name',
            Value: name
        },
        {
            Label: 'Address 1',
            Value: address1
        },
        {
            Label: 'Address 2',
            Value: address2
        },
        {
            Label: 'City',
            Value: city
        },
        {
            Label: 'State',
            Value: state_code
        },
        {
            Label: 'Is_gstn_registered',
            Value: Isgstnregistered
        },
        {
            Label: 'GSTIN Number',
            Value: Gstin
        },
        ],
    },
    UI.Facets               : [{
        $Type : 'UI.ReferenceFacet',
        ID    : 'BusinessPFacet',
        Label : 'BusinessP',
        Target: '@UI.FieldGroup#BusinessP',
    }, ],
);

annotate selectElectronics.Store with @(
    UI.LineItem             : [

        {
            Label: 'Store Id',
            Value: storeid
        },
        {
            Label: 'Name',
            Value: name
        },
        {
            Label: 'Address 1',
            Value: address1
        },
        {
            Label: 'Address 2',
            Value: address2
        },
        {
            Label: 'City',
            Value: city
        },
        {
            Label: 'State',
            Value: state_code
        },
        {
            Label: 'pincode',
            Value: pincode
        },
    ],
    UI.FieldGroup #StoreP: {
        $Type: 'UI.FieldGroupType',
        Data : [
             {
            Label: 'Store Id',
            Value: storeid
        },
        {
            Label: 'Name',
            Value: name
        },
        {
            Label: 'Address 1',
            Value: address1
        },
        {
            Label: 'Address 2',
            Value: address2
        },
        {
            Label: 'City',
            Value: city
        },
        {
            Label: 'State',
            Value: state_code
        },
        {
            Label: 'pincode',
            Value: pincode
        },
        ],
    },
    UI.Facets               : [{
        $Type : 'UI.ReferenceFacet',
        ID    : 'BusinessPFacet',
        Label : 'StoreP',
        Target: '@UI.FieldGroup#StoreP',
    }, ],
);



annotate selectElectronics.Product with @(
    UI.LineItem           : [
        {
            Label: 'Product id',
            Value: p_id
        },
        {
            Label: 'Product Name',
            Value: name
        },
        {
            Label: 'Product Image URL',
            Value: imageURL
        },
        {
            Label: 'Cost Price',
            Value: costPrice
        },
        {
            Label: 'Sell Price',
            Value: sellPrice
        },
    ],
    UI.FieldGroup #product: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                Label: 'Product id',
                Value: p_id
            },
            {
                Label: 'Product Name',
                Value: name
            },
            {
                Label: 'Product Image URL',
                Value: imageURL
            },
            {
                Label: 'Cost Price',
                Value: costPrice
            },
            {
                Label: 'Sell Price',
                Value: sellPrice
            },
        ],
    },
    UI.Facets             : [{
        $Type : 'UI.ReferenceFacet',
        ID    : 'productFacet',
        Label : 'product facets',
        Target: '@UI.FieldGroup#product'
    }, ],

);



annotate selectElectronics.Stock with @(
    UI.LineItem:[
        {
            Label:'Store Id',
            Value:storeId_ID
        },
         {
            Label:'Product Id',
            Value:productId_ID
        },
        {
            Label:'Stock Quantity',
            Value:stock_qty
        }
    ],
    UI.FieldGroup #stock :{
        $Type:'UI.FieldGroupType',
        Data:[
             {
            Label:'Store Id',
            Value:storeId_ID
        },
         {
            Label:'Product Id',
            Value:productId_ID
        },
         {
            Label:'Stock Quantity',
            Value:stock_qty
        }
        ],
    },
      UI.Facets:[
        {
            $Type:'UI.ReferenceFacet',
            ID:'stockFacet',
            Label:'stock facets',
            Target:'@UI.FieldGroup#stock'
        },
    ],
);


annotate selectElectronics.BusinessPartner with {
    state @(
        Common.ValueListWithFixedValues: true,
        Common.ValueList               : {
            Label         : 'State',
            CollectionPath: 'States',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: state_code,
                    ValueListProperty: 'code'
                },

                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'description'
                },
            ]
        }
    );
};

annotate selectElectronics.Store with {
    state @(
        Common.ValueListWithFixedValues: true,
        Common.ValueList               : {
            Label         : 'State',
            CollectionPath: 'States',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: state_code,
                    ValueListProperty: 'code'
                },

                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'description'
                },
            ]
        }
    );
};

annotate selectElectronics.Stock with {
    storeId @(
        Common.ValueListWithFixedValues: true,
        Common.ValueList : {
            Label: 'Store id',
            CollectionPath : 'Store',
            Parameters: [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : storeId_ID,
                    ValueListProperty : 'ID'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'name'
                },
             
            ]
        }
    );
productId @(
        Common.ValueListWithFixedValues: true,
        Common.ValueList : {
            Label: 'Product id',
            CollectionPath : 'Product',
            Parameters: [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : productId_ID,
                    ValueListProperty : 'ID'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'name'
                },
             
            ]
        }
    );
}
