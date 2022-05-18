@istest
public class AddPrimaryContactTest
{
	static testmethod void testList()
    {
        List<Account> lstTestAccounts = new List<Account>();
        for(integer i =0;i<50;i++)
        {
            lstTestAccounts.add(new Account(BillingState = 'CA',Name = 'Test'+i));
        }
        for(integer j =0;j<50;j++)
        {
            lstTestAccounts.add(new Account(BillingState = 'NY',Name = 'Test'+j));
        }
        insert lstTestAccounts;
        contact c = new contact();
        c.FirstName = 'demo';
        c.LastName = 'demo';
        insert c;
        String state = 'CA';
        
        AddPrimaryContact addPC = new AddPrimaryContact(c,state);
        test.startTest();
        system.enqueueJob(addPC);
        test.stopTest();
    }
}