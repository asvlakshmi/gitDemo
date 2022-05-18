/*    
    Author     : Abhishek Yadav
    Date       : 12/4/2012
    Description: Test Class for DisplaySearchFields.  
*/
@isTest
private class DisplaySearchFields_TEST 
{
    static testMethod void testSearchFieldComponent() 
    {
        Product2 Prod = new Product2(Name= 'test Product',family='Energy',Business__c='Energy 3',ProductCode='12345');
        database.insert(prod);
        DisplaySearchFields controller = new DisplaySearchFields();
        controller.SearchFilter = new String[4];
        controller.pickListType = 'PROD';
        controller.SearchFilter[0] = 'Energy';
        controller.SearchFilter[1] = Label.CL00012;      
        PageReference pageRef= Page.accountProduct;  
        test.startTest();     
        controller.init();
        For(integer index=1; index<DisplaySearchFields.MAX_NUMBER_OF_PL; index++)
        {
            pageRef.getParameters().put('level',String.valueof(index));
            if(index==6)
                controller.levels[5] = Label.cl00012;
            Test.setCurrentPageReference(pageRef);
            controller.picklistrefresher(); 
        }
        test.stopTest();     
    }
}