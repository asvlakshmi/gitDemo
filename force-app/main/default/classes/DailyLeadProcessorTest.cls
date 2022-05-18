@isTest
public class DailyLeadProcessorTest 
{
    
    public static String CRON_EXP = '0 0 0 15 3 ? 2022';
    @testSetup
    static void testDataSetup()
    {
        List<Lead> lstLeads = new List<Lead>();
        for(integer i=0;i<200;i++)
        {
            lstLeads.add(new Lead(LastName='LEAD'+i,company = 'testCompany',status = 'open'));
        }
        insert lstLeads;
    }
    public static testmethod void testDailyLeadProcessorTest()
    {
        test.startTest();
        System.schedule('ScheduledApexTest',
            CRON_EXP, 
            new DailyLeadProcessor());  
        test.stopTest();
    }

}