global class LeadProcessor implements database.Batchable<sobject> 
{
	global database.QueryLocator start(database.BatchableContext bc)
    {
        return database.getQuerylocator('select Id,LeadSource from Lead');
    }
    global void execute(database.BatchableContext bc, List<Lead> scope)
    {
		for(Lead objLead: scope)  
        {
            objLead.LeadSource = 'Dreamforce';
        }
        update scope;
        system.debug('LEad::::::'+scope);
    }
    global void finish(database.BatchableContext bc)
    {
        
    }
}