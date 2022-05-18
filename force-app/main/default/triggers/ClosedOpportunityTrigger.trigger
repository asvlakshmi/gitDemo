trigger ClosedOpportunityTrigger on Opportunity (after insert,after update) 
{
    //variable declaration
    Set<Id> setOptIds = new Set<Id>();
    List<Task> lstTasks = new List<Task>();
    Task objTask = new Task();
    for(Opportunity objOpt: Trigger.New)
    {
        if(Trigger.isInsert)
        {
            if(objOpt.StageName== 'Closed Won')
            {
                objTask = new Task();
                objTask.whatId = objOpt.Id;
                objTask.Subject = 'Follow Up Test Task';
                objTask.Priority ='Normal';
                lstTasks.add(objTask);
            }
        }
        if(Trigger.isUpdate)
        {
            if((objOpt.StageName== 'Closed Won') && ( objOpt.StageName != Trigger.oldMap.get(objOpt.Id).StageName))
            {
                objTask = new Task();
                objTask.whatId = objOpt.Id;
                objTask.Subject = 'Follow Up Test Task';
                objTask.Priority ='Normal';
                lstTasks.add(objTask);
            }
        }
        
    }
    if(lstTasks!=null && lstTasks.size()>0)
    {
        insert lstTasks;
    }
}