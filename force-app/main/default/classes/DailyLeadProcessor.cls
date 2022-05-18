global class DailyLeadProcessor implements Schedulable   
{
	global void execute(SchedulableContext sc)
    {
        List<Lead> lstLeads = [select Id,LeadSource from Lead where LeadSource = '' limit 200];
        for(Lead objLead: lstLeads)  
        {
            objLead.LeadSource = 'Dreamforce';
        }
        update lstLeads;
    }
        
}