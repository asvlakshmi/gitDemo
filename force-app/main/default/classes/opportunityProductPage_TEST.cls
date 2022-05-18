/*    
    Author     : Abhishek Yadav
    Date       : 12/4/2012
    Description: Test Class for opportunityProduct.  
*/
@isTest(seeAllData = true)
private class  opportunityProductPage_TEST
{
    static testMethod void testopportunityProductPage()
    {
        Opportunity opp = new Opportunity(name = 'test opportunity',StageName ='Prospecting', CloseDate = system.today());
        database.insert(opp);
        
        Product2 Prod = new Product2(Name= 'test Product',family='Energy',Business__c='Energy 3',ProductCode='12345');
        database.insert(prod);
        
        List<String> keywords = New List<String>();
        keywords.add('test');
        List<String> filters = New List<String>();
        filters.add('Energy');
        filters.add('Energy 3');
            
        Utils_DataSource dataSource = Utils_Factory.getDataSource('PROD');
        Utils_DataSource.Result searchResult = dataSource.Search(keywords,filters);
        sObject tempsObject = searchResult.recordList[0];
                    
         Test.startTest();
            
            PageReference pageRef= Page.opportunityProduct;                    
            VFC_ControllerBase basecontroller = new VFC_ControllerBase();  
            System.debug('~~~~~~~~~~Start of Test~~~~~~~~~~');
            ApexPages.StandardController cc1 = new ApexPages.StandardController(new OpportunityProduct__c());            
            opportunityProduct  ProductforProductLine = new opportunityProduct(cc1);                        
            DisplaySearchResults componentcontroller1 =ProductforProductLine.resultsController;           
            DisplaySearchFields componentcontroller = new DisplaySearchFields();    
            componentcontroller.pickListType = 'PROD';                                 
            componentcontroller.init();   
            componentcontroller.level1 = 'Energy';
            componentcontroller.level2 = 'Energy 3';   
            componentcontroller.searchText = 'te';
            componentcontroller.key = 'searchComponent';
            componentcontroller.PageController = ProductforProductLine;             
            pageRef.getParameters().put('key','searchComponent');
            pageRef.getParameters().put(label.CL00010,opp.Id);
            Test.setCurrentPageReference(pageRef);               
            ProductforProductLine.search();
            ProductforProductLine.clear();      
            ProductforProductLine.PerformAction(tempsObject, ProductforProductLine); 
            ProductforProductLine.clear(); 
            componentcontroller.searchText = '';
            componentcontroller.level1=Label.CL00012;   
            ProductforProductLine.search();            
            Test.stopTest();
        
    }
}