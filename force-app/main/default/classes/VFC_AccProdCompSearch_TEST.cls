/*    
    Author     : Abhishek Yadav
    Date       : 12/4/2012
    Description: Test Class for VFC_AccProdCompSearch.  
*/
@isTest(seeAllData = true)
private class  VFC_AccProdCompSearch_TEST
{
    static testMethod void testVFC_AccProdCompSearch()
    {
        Account ac = new Account(name = 'Test Account');
        database.insert(ac);
        
        Product2 Prod = new Product2(Name= 'test Product',family='Energy',Business__c='Energy 3',ProductCode='12345');
        database.insert(prod);
        
        AccountProduct__C accProd = new AccountProduct__C(Account__c=ac.id, Product__c=prod.id,ProductFamily__c='Energy',Business__c='Energy 3');
        database.insert(accProd);
        
        Competitor__c comp =new Competitor__c(name = 'Test',country__c='India');
        database.insert(comp);
        
            List<String> keywords = New List<String>();
            keywords.add('test');
            List<String> filters = New List<String>();
            filters.add('India');
                
            Utils_DataSource dataSource = Utils_Factory.getDataSource('COMP');
            Utils_DataSource.Result searchResult = dataSource.Search(keywords,filters);
            sObject tempsObject = searchResult.recordList[0];
                    
         Test.startTest();
            
            PageReference pageRef= Page.VFP_AccProdCompSearch;                    
            System.debug('~~~~~~~~~~Start of Test~~~~~~~~~~');
                VFC_ControllerBase basecontroller = new VFC_ControllerBase();  
            ApexPages.StandardController cc1 = new ApexPages.StandardController(new APC__c());            
            VFC_AccProdCompSearch  ProductforProductLine = new VFC_AccProdCompSearch(cc1);                        
            DisplaySearchResults componentcontroller1 =ProductforProductLine.resultsController;                                           
            ProductforProductLine.level1 = 'India';
            ProductforProductLine.searchText = 'te';       
            pageRef.getParameters().put(label.CL00034,accProd.id);
            pageRef.getParameters().put(label.CL00035,accProd.id);
            Test.setCurrentPageReference(pageRef);               
            ProductforProductLine.search();
            ProductforProductLine.clear();      
            ProductforProductLine.PerformAction(tempsObject, ProductforProductLine); 
            ProductforProductLine.clear(); 
            ProductforProductLine.searchText = '';
            ProductforProductLine.level1=Label.CL00012;   
            ProductforProductLine.search();            
            Test.stopTest();
        
    }
}