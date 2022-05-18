public class ProductDataSource extends Utils_DataSource
{     
     //    Query Parameters - Main Query and Different cluases which will be used conditionally
        static String query1 = 'Select name, Business__c, family, ProductCode from product2';
        static String query2 = ' where ';
        static String query3 = ' AND ';
        static String query4 = 'Name like \'%';
        static String query5 = '%\'';
        static String query6 = 'family=\'';
        static String query7 = ' ORDER BY Name';
        static String query8 = 'Business__c=\'';
        static String query9 = '\'';
     //    End of Query String cretaion
                          
     // Define Columns Label and displayed field  
     public override List<SelectOption> getColumns()
     {
        List<SelectOption> Columns = new List<SelectOption>();
        
        Columns.add(new SelectOption('Field1__c',sObjectType.product2.fields.Name.getLabel())); // First Column
        Columns.add(new SelectOption('Field2__c',sObjectType.product2.fields.family.getLabel())); 
        Columns.add(new SelectOption('Field3__c',sObjectType.product2.fields.Business__c.getLabel())); // Last Column
        return Columns;
     }
        
     //    Main Search Method
     public override Result Search(List<String> keyWords, List<String> filters)
     {
        //    Initializing Variables      
        String searchText;       
        String family;
        String business;
        List<sObject> results = New List<sObject>();
        List<sObject> tempResults = New List<sObject>();
        Utils_Sorter sorter = new Utils_Sorter();
        List<Id> compId = New List<Id>();
        Utils_DataSource.Result returnedResult = new Utils_DataSource.Result();   
        returnedResult.recordList = new List<DataTemplate__c>();
        Map<Object, String> countries = New Map<Object, String>();
        Map<String,sObject> resultData = New Map<String,sObject>();
        Map<Object, String> familyPickList = New Map<Object, String>();
        Map<Object, String> businessPickList = New Map<Object, String>();
        Map<Integer,DataTemplate__c> resultMap = new Map<Integer,DataTemplate__c>();
        List<sObject> resultset = New List<sObject>();
        //    End of Variable Initialization
        
        //    Assigning the User input Search Filter and Search criteria to the Variables
        if(!(filters[0].equalsIgnoreCase(Label.CL00012)))
            family = filters[0];
        if(!(filters[0].equalsIgnoreCase(Label.CL00012)) && !(filters[1].equalsIgnoreCase(Label.CL00012)))
            business = filters[1];

        if(keywords != null && keywords.size()>0)
            searchText = keyWords[0];
        else 
            searchText = '';
        //    End of Assignment
        
        if(searchText != NULL && searchText!= '')
        {
            if(business != NULL && family!=null)
            {
                results = Database.query(query1+query2+query4+searchText+query5+query3+query6+family+query9+query3+query8+business+query9+query7);
            }
            else if(business != NULL && family == null)
            {
                results = Database.query(query1+query2+query4+searchText+query5+query3+query8+business+query9+query7);
            }
            else if(business == NULL && family != null)
            {
                results = Database.query(query1+query2+query4+searchText+query5+query3+query6+family+query9+query7);
            }
            else
            {
                results = Database.query(query1+query2+query4+searchText+query5+query7);
            }
        }
        else
        {
            if(business != NULL && family !=null)
            {
                results = Database.query(query1+query2+query6+family+query9+query3+query8+business+query9+query7);
            }
            else if(business != NULL && family == null)
            {
                 results = Database.query(query1+query2+query8+business+query9+query7);
            }
            else if(business == NULL && family != null)
            {
                 results = Database.query(query1+query2+query6+family+query9+query7);
            }
        }
        System.debug('#### results: ' +  results );
        //    End of Search
                
        //    Creation of Map of Business Picklist Value and corresponding Label
        Schema.DescribeFieldResult businessPickVal = Schema.sObjectType.Product2.fields.Business__c;
        for (Schema.PickListEntry PickVal : businessPickVal.getPicklistValues())
        {
            businessPickList.put((Object)PickVal.getValue(),PickVal.getLabel());
        }
        //    End of Picklist Map creation     
        
        //    Creation of Map of Family Picklist Value and corresponding Label
        Schema.DescribeFieldResult familyPickVal = Schema.sObjectType.Product2.fields.family;
        for (Schema.PickListEntry PickVal : familyPickVal.getPicklistValues())
        {
            familyPickList.put((Object)PickVal.getValue(),PickVal.getLabel());
        }
          
        
        //    Start of processing the Saerch Result to prepare the final result set
        tempResults.clear();
        for (sObject obj : results)
        { 
            product2 records = (product2)obj;
            DataTemplate__c prod = New DataTemplate__c ();
            prod.put('Field1__c',records.get('Name'));
            if(records.get('Business__c') != null)
            {                
                prod.put('Field2__c', businessPickList.get(records.get('Business__c')));            
            }
            if(records.get('family') != null)
            {
                    prod.put('Field3__c',familyPickList.get(records.get('family')));
            }
            if(records.get('ID') != null)
            prod.put('Field4__c',records.get('ID'));        
            tempResults.add(prod);              
        }
        System.debug('#### Results without Country Filter: ' +  tempResults);
        returnedResult.recordList.clear();
        if(tempResults!=null)
        returnedResult.recordList.addAll(tempResults);        
        //    End of Processing and prepaation of the final result Set
        
        returnedResult.recordList = (List<sObject>)sorter.getSortedList(returnedResult.recordList, 'Field1__c', true);
        System.debug('#### Final Result :' + returnedResult);
        
        resultset.addAll(returnedResult.recordList);
        returnedResult.numberOfRecord = resultset.size();

        if(returnedResult.numberOfRecord > Integer.ValueOf(Label.CL00013))
        {
            returnedResult.recordList.clear();
            for(Integer count=0; count< Integer.ValueOf(Label.CL00013); count++)
            {
                returnedResult.recordList.add(resultset[count]);      
            }
        }        
        return returnedResult;
     }
}