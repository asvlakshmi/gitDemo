public abstract class Utils_DataSource
{
    public Class Result
    {
        public Long errorCode; // Error code
        public Long numberOfPage; // Number of page potentially retrieved (number of records found / number of record per page)
        public Long numberOfRecord; // Number of record found
        public Long pageNumber; // Number of the page that is currently fetched 
        public String returnCode; // S or E (S=Sucesss, E=Error)
        public String returnMessage; // Technical Message
        public String functionalMessage; // Functional Message
        public List<sObject> recordList; // Results
    }    
     // Define Columns Label and displayed field  
     public abstract List<SelectOption> getColumns();  
        
     // Main Search Method
     public abstract Result Search(List<String> KeyWords, List<String> Criteria);
}