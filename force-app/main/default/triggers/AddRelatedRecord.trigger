trigger AddRelatedRecord on Account (after Insert,after Update) 
{
    
    List<Opportunity> lstOpp = new List<Opportunity>();
    Opportunity objOpp = new Opportunity();
    Map<Id,Account> mapAccountWithOpportunities = new Map<Id,Account>([select Id,(select Id from Opportunities) from account where Id IN: trigger.new]);
     
    for(Account objAcc: trigger.new)
    {
        if(mapAccountWithOpportunities.get(objAcc.Id).Opportunities.size() == 0)
        {
            objOpp = new Opportunity();
            objOpp.Name=objAcc.Name + ' Opportunity';
            objOpp.StageName='Prospecting';
            objOpp.CloseDate=System.today().addMonths(1);
            objOpp.AccountId=objAcc.Id;
            lstOpp.add(objOpp);
        }
    }
    if(lstOpp!=null && lstOpp.size()>0)
    {
        insert lstOpp;
    }
    
}