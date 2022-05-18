/*    
    Author     : Abhishek Yadav
    Date       : 12/4/2012
    Description: Test Class for DisplaySearchResults.  
*/
@isTest
private class DisplaySearchResults_TEST {

    static testMethod void testDisplaySearchResultsComponent() {
        // TO DO: implement unit test
        
     Test.startTest();
       DisplaySearchResults  controller = new DisplaySearchResults();      
        VFC_ControllerBase basePageController = new VFC_ControllerBase();
        VCC_ControllerBase basecomponentcontroller = new VCC_ControllerBase();

        basePageController.getThis();
        basePageController.getComponentControllerMap();        
        basePageController.setComponentControllerMap('resultsComponent',controller );             
        basecomponentcontroller.pageController = basePageController ;
        basecomponentcontroller.key = 'resultsComponent';
        basecomponentcontroller.pageController = basePageController ;
            Product2 Prod = new Product2(Name= 'test Product',family='Energy',Business__c='Energy 3',ProductCode='12345');
        database.insert(prod);
        
            List<String> keywords = New List<String>();
            keywords.add('test');
            List<String> filters = New List<String>();
            filters.add('Energy');
            filters.add('Energy 3');
                
            Utils_DataSource dataSource = Utils_Factory.getDataSource('PROD');
            Utils_DataSource.Result  tempresult = new Utils_DataSource.Result();
            tempresult = dataSource.Search(keywords,filters);
                 
        controller.columnList = dataSource.getColumns();
        
        Schema.sObjectType objType;
        Schema.DescribeSObjectResult objDescribe;
        Map<String, Schema.SObjectField> objFields;
        Map<String, Schema.DisplayType> ObjFieldTypes = new Map<String, Schema.DisplayType>();
        Schema.SObjectField field;
        Schema.DescribeFieldResult fieldDescribe;
        Schema.DisplayType fieldType;
        String[] dataType;
        for(integer i=0;i < 4;i++){
        controller.columnList.add(new SelectOption('Field8__c','commercial Reference'));            
        }
        
       
        List<DataTemplate__c> dataTemplates = (List<DataTemplate__c>)tempresult.recordList;
        Set<Object> exisRec = new Set<Object>();
        for(DataTemplate__c dt: dataTemplates )
        {
            exisRec.add(dt.Field1__c);
        }
        controller.existingRecords = exisRec;

            objType= DataTemplate__c.getSObjectType();
            objDescribe =objType.getdescribe();
            objFields =objDescribe.fields.getMap();
            for(SelectOption selectValue:controller.columnList)
            {
                field = objFields.get(selectValue.getvalue());
                fieldDescribe = field.getdescribe();
                fieldType = fieldDescribe.getType(); 
                objFieldTypes.put(selectValue.getvalue(),FieldType);          
            }
            
            //dataType = controller.getDataType(objFields,controller.columnList);
            
        
        PageReference pageRef= Page.accountProduct;
        pageRef.getParameters().put('sortColumn','4');

        controller.setpageNumber(2);
        controller.recordsPerPage = 4;
        controller.getComponentController();

       controller.displayRecordList=tempresult.recordList; 

       controller.pageNumber = 5; 
       controller.numberOfPages = 2;
       controller.getpageNumber();
       
       controller.pageNumber = 0; 
       controller.getpageNumber();

        List<String> FieldForKeyList = new List<String>();

        DisplaySearchResults.DataDisplayWrapper[] wrapperclass = new DisplaySearchResults.DataDisplayWrapper[]{};
        system.debug('ssss'+tempresult.recordList);
        displaySearchResults.DataDisplayWrapper wrapperclass1 = new DisplaySearchResults.DataDisplayWrapper(tempresult.recordList[0],1,1,controller.columnList,basePageController,objFields,FieldForKeyList ,controller.existingRecords,objFieldTypes);
        wrapperclass = controller.getDisplaySearchResults();
        
        wrapperclass1.Action1();       
        List<sObject> sObj = controller.getSelectedObjects();
        Test.setCurrentPageReference(pageRef);
        system.debug('current pagereff'+system.currentPageReference().getparameters());
        controller.getrecordsDisplay();
        controller.first();
        controller.last();
        controller.previous();
        controller.next();
        controller.sortColumn();
        controller.getpageNumber();
        controller.pageNumberRenderer();
     Test.stopTest();
        
        
       
    }
}