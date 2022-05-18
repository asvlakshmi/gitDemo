Public Class competitorPicklistManager implements Utils_PicklistManager
{    
    // Return name of the levels
    Public list<String> getPickListLabels()
    {
        List<String> Labels = new List<String>();
            Labels.add('Country');
        return Labels;
    } 
    // Return dependent picklist value 
    public List<SelectOption> getPicklistValues(Integer i, String S)
    {
       List<SelectOption> options = new  List<SelectOption>(); 
            options.add(new SelectOption('--None--','--None--'));   
            Schema.DescribeFieldResult pickList = Schema.sObjectType.competitor__c.fields.country__c;            
            for (Schema.PickListEntry PickVal : pickList.getPicklistValues())
            {
                options.add(new SelectOption(PickVal.getValue(),PickVal.getLabel()));
            }      
       return  options;  
    }
}