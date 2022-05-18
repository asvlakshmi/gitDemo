public class NewCaseListController 
{
	public List<case> getNewCases()
    {
        List<case> lstCases = new List<case>();
        lstCases =[select Id,CaseNumber ,status from case where status =: 'New'];
        return lstCases;
        
    }
}