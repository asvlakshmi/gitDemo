public class CompetitorDataSource extends Utils_DataSource
{     
     //    Query Parameters - Main Query and Different cluases which will be used conditionally
        static String query1 = 'Select name, country__c from competitor__c';
        static String query2 = ' where ';
        static String query3 = ' AND ';
        static String query4 = 'Name like \'%';
        static String query5 = '%\'';
        static String query6 = 'country__C=\'';
        static String query7 = ' ORDER BY Name';
        static String query9 = '\'';
     //    End of Query String cretaion
                          
     // Define Columns Label and displayed field  
     public override List<SelectOption> getColumns()
     {
        List<SelectOption> Columns = new List<SelectOption>();
        
        Columns.add(new SelectOption('Field1__c',sObjectType.competitor__c.fields.Name.getLabel())); // First Column
        Columns.add(new SelectOption('Field2__c',sObjectType.competitor__c.fields.country__c.getLabel())); // Last Column
        return Columns;
     }
        
     //    Main Search Method
     public override Result Search(List<String> keyWords, List<String> filters)
     {
        //    Initializing Variables      
        String searchText;       
        String country;
        List<sObject> results = New List<sObject>();
        List<sObject> tempResults = New List<sObject>();
        Utils_Sorter sorter = new Utils_Sorter();
        List<Id> compId = New List<Id>();
        Utils_DataSource.Result returnedResult = new Utils_DataSource.Result();   
        returnedResult.recordList = new List<DataTemplate__c>();
        Map<Object, String> countries = New Map<Object, String>();
        Map<String,sObject> resultData = New Map<String,sObject>();
        Map<Object, String> countryPickList = New Map<Object, String>();
        Map<Integer,DataTemplate__c> resultMap = new Map<Integer,DataTemplate__c>();
        List<sObject> resultset = New List<sObject>();
        //    End of Variable Initialization
        
        //    Assigning the User input Search Filter and Search criteria to the Variables
        if(!(filters[0].equalsIgnoreCase(Label.CL00012)))
            country = filters[0];

        if(keywords != null && keywords.size()>0)
            searchText = keyWords[0];
        else 
            searchText = '';
        //    End of Assignment
        
        if(searchText != NULL && searchText!= '')
        {
            if(country != NULL && country != Label.CL00012)
            {
                results = Database.query(query1+query2+query4+searchText+query5+query3+query6+country+query9+query7);
            }
            else 
            {
                results = Database.query(query1+query2+query4+searchText+query5+query7);
            }            
        }
        else
        {
             results = Database.query(query1+query2+query6+country+query9+query7);   
        }
        System.debug('#### results: ' +  results );
        //    End of Search
                
        //    Creation of Map of country
        Schema.DescribeFieldResult businessPickVal = Schema.sObjectType.competitor__c.fields.country__c;
        for (Schema.PickListEntry PickVal : businessPickVal.getPicklistValues())
        {
            countryPickList.put((Object)PickVal.getValue(),PickVal.getLabel());
        }
        //    End of Picklist Map creation     
                  
        
        //    Start of processing the Saerch Result to prepare the final result set
        tempResults.clear();
        for (sObject obj : results)
        { 
            competitor__c records = (competitor__c)obj;
            DataTemplate__c comp = New DataTemplate__c ();
            comp.put('Field1__c',records.get('Name'));
            if(records.get('country__c') != null)
            {                
                comp.put('Field2__c', countryPickList.get(records.get('country__c')));            
            }
            if(records.get('ID') != null)
            comp.put('Field3__c',records.get('ID'));        
            tempResults.add(comp);              
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