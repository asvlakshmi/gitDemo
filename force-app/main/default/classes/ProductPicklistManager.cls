Public Class ProductPicklistManager implements Utils_PicklistManager
{
    Map<String,String> ProductBusinessMap; // Map between Values and Labels for the Product Business Picklist
    
    // Return name of the levels
    Public list<String> getPickListLabels()
    {
        List<String> Labels = new List<String>();
        Labels.add('Product Family');
        Labels.add('Business');
        return Labels;
    } 

    // Return dependent picklist value 
    public List<SelectOption> getPicklistValues(Integer i, String S)
    {
        if(ProductBusinessMap == null)
        {
            ProductBusinessMap = new Map<String,String>(); 
            Schema.DescribeFieldResult pickList = Schema.sObjectType.Product2.fields.Business__c;
            
            for (Schema.PickListEntry PickVal : pickList.getPicklistValues())
            {
                ProductBusinessMap.put(PickVal.getValue(),PickVal.getLabel());
            }
        }
             
       List<SelectOption> options = new  List<SelectOption>();
       
       If(S == '--None--')
           return null;
          
       options.add(new SelectOption('--None--','--None--')); 
 
       // Populate Family fields
       if(i==1)
       {
            Schema.DescribeFieldResult family = Schema.sObjectType.Product2.fields.Family;
            for (Schema.PickListEntry PickVal : family.getPicklistValues())
            {
                options.add(new SelectOption(PickVal.getValue(),PickVal.getLabel()));
            }
       } 
       
       // Select a Business
       if(i==2)
       {    
           set<String> prod = new set<String>();     
           For(Product2 P:[SELECT id,Business__c FROM Product2 WHERE family=:S AND Business__c!=null])
           {
               prod.add(p.Business__c);
           }
           for(String buss:prod)
           {
               if(ProductBusinessMap.get(buss) != null)               
                    options.add(new SelectOption(buss,ProductBusinessMap.get(buss))); 
               else            
                    options.add(new SelectOption(buss,buss));    
           } 
       } 
       return  options;  
    }
}