@isTest
public class LeadProcessorTest 
{
    @testSetup
    public static void testData()
    {
        List<Lead> lstLeads = new List<Lead>();
        for(integer i=0;i<200;i++)
        {
            lstLeads.add(new Lead(LastName='LEAD'+i,company = 'testCompany',status = 'open'));
        }
        insert lstLeads;
    }
	public static testmethod void TestLeadProcessorTest()
    {
        test.startTest();
        LeadProcessor leadBatch = new LeadProcessor();
		Id batchId = database.executeBatch(leadBatch);  
        test.stopTest();
        
    }
}