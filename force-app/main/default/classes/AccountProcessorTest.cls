@isTest
public class AccountProcessorTest {
	public static TestMethod void TestAccountProceesorTest()
    {
        Account acct = new Account();
        acct.Name = 'TestAccount';
        insert acct;
        system.debug('Account:::::'+acct);
        
        Contact con = new Contact();
        con.FirstName = 'Test';
        con.LastName = 'contact';
        con.AccountId = acct.Id;
        insert con;
        system.debug('Contact::::::' +con);
        List<Id> accIds = new List<Id>();
        accIds.add(acct.id);
        
        Test.startTest();
        AccountProcessor.countContacts(accIds);
        Test.stopTest();
        
         Account ACC = [select Number_of_Contacts__c from Account where id = :acct.id LIMIT 1];
        System.assertEquals(ACC.Number_of_Contacts__c, 1);
    }
}