@RestResource(URLMapping='/RestToSearchAndFindAccounts/Account/*')

global class ToSearchAndFindTheAccounts
{
    @HttpGet
    global static myResponse doGet()
    {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        
        myResponse objResponse = new myResponse();
        String accountID = req.requestURI.substring(req.requestURI.lastIndexof('/')+1);
        
        if(doSearch(accountID))
        {
            searchAccounts(req,res,objResponse);
        }
        else
        {
            findAccount(res,objResponse,accountID);
        }
        return objResponse; 
    }
    //method to get boolean value for search
    private static boolean dosearch(String accountID)
    {
        if(accountID == 'Account')
        {
            return true;
        }
        return false; 
    }
    //method to search accounts based on string passed from external system
    private static void searchAccounts(RestRequest req, RestResponse res, myResponse response)
    {
        String searchterm = req.params.get('Name');
        system.debug('searchterm::::::::::::::::;'+searchterm);
        if(searchterm == null || searchterm == '')
        {
            response.status = 'Error';
            response.message = 'Please specify a valid Name';
        }
        else 
        {
            String searchText = '%'+searchterm+'%';
            system.debug('searchText ::::::::::::::::;'+searchText);
            List<Account> searchresults = [select Name, Type, Industry from Account where Name LIKE: searchText];
            system.debug('searchresults:::::::::::::::::::'+searchresults);
            if(searchresults != null && searchresults.size()>0)
            {
                response.acctList.addAll(searchresults);
                response.status= 'Success';
            }
            else{
                response.status = 'Error';
                response.message  = 'No records found matching your keyword. Please try other keyword';
            }
        }
    }
    //method to return record based on accountId which is passing from external system
    private static void findAccount(RestResponse res, myResponse response, String accountID)
    {
        if(accountID != null && accountID != '')
        {
            List<Account> results = [select Name, Type, Industry from Account where ID = :accountID];
            if(results != null && results.size()>0)
            {
                response.acctList.add(results[0]);
                response.status = 'Success';
            }
            else
            {
                response.status = 'Error';
                response.message = 'Invalid Record ID. Please provide correct ID';
            }
        }
        else
        {
            response.status = 'Error';
            response.message = 'No ID supplied';
        } 
    }
    //wrapper class
    global class myResponse
    {
        public List<Account> acctList;
        public String status;
        public String message;
        
        public myResponse(){
            acctList = new List<Account>();
        }
    
    }
}