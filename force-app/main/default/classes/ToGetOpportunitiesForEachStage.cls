@RestResource(URLMapping='/RestToGetOpportunities/Opportunities/*')

global class ToGetOpportunitiesForEachStage
{
    @HttpGet
    global static List<Opportunity> getList()
    {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String stage = req.RequestURI.substring(req.requestURI.lastindexOf('/')+1);
        List<Opportunity> lstOpportunities = new List<Opportunity>();
        if(stage == 'All')
        {
            lstOpportunities =[select Name,StageName,Type from Opportunity];
        }
        else if(stage == 'Open')
        {
             lstOpportunities =[select Name,StageName from Opportunity Where StageName NOT IN ('Closed Won','Closed Lost')];
        }
        else if(stage == 'Closed')
        {
             lstOpportunities =[select Name,StageName from Opportunity Where StageName IN ('Closed Won','Closed Lost')];
        }
        else if(stage!=null && stage!='All' && stage != 'Open' && stage != 'Closed')
        {
            lstOpportunities =[select Name,StageName from Opportunity Where StageName =:stage];
        }
        return lstOpportunities;
    }
    
}