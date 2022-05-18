/*
    Author          : Abhishek Yadav   
    Date Created    : 22/01/2012 
    Description     : Controller for accountProductPage.
*/
Public class accountProduct extends VFC_ControllerBase {
     //Iniatialize variables
    private AccountProduct__c accountProd;
    Private id accid;
    private account account;
    private Utils_DataSource dataSource;
    public List<SelectOption> columns{get;set;}
    public List<DataTemplate__c> fetchedRecords{get;set;}
    public String interfaceType{get;set;}
    public String searchKeyword{get; set;}
    public List<String> keywords;
    public List<String> filters{get; set;} 
    public Boolean DisplayResults{get;set;}
    public Utils_DataSource.Result searchResult ;
    Public Utils_PicklistManager plManager;
    public string searchText{get;set;}       
    public String level1{set; get;}
    public String level2{get; set;}
    public Boolean displayError{get;set;}
    Public List<String> Labels{get;set;}
    public List<SelectOption> items1{set; get;}
    public List<SelectOption> items2{set; get;}   
    private DataTemplate__c prods = New DataTemplate__c();
    public String fieldName{get;set;}  
    Private Boolean updtReq;      
    public DisplaySearchFields searchController 
    {
        set;
        get
        {
            if(getcomponentControllerMap()!=null)
            {
                DisplaySearchFields displaySearchFields;
                displaySearchFields = (DisplaySearchFields)getcomponentControllerMap().get('searchComponent');
                system.debug('--------displaySearchFields-------'+displaySearchFields );
                if(displaySearchFields!= null)
                return displaySearchFields;
            } 
            return new DisplaySearchFields();
        }
    } 
    public DisplaySearchResults resultsController 
    {
        set;
        get
        {
            if(getcomponentControllerMap()!=null)
            {
                DisplaySearchResults displaySearchResults;
                displaySearchResults = (DisplaySearchResults)getcomponentControllerMap().get('resultComponent');
                system.debug('--------displaySearchResults -------'+displaySearchResults );                
                if(displaySearchResults!= null)
                return displaySearchResults;
            }  
            return new DisplaySearchResults();
        }
    }
     //Constructor
    public accountProduct(ApexPages.StandardController controller)
    {
        System.Debug('****** Initializing the Properties and Variables Begins for VFC67_ProductSearch******');            
        accountProd= (AccountProduct__c)controller.getRecord();  
        keywords = new List<String>();
        filters = new List<String>();
        columns = new List<SelectOption>();
        Labels = new List<String>();      
        displayError=false;                     
        interfaceType=Label.CL00011; 
        system.debug('----filters-----'+filters);
        system.debug('----keywords -----'+keywords );          
        dataSource = Utils_Factory.getDataSource(interfaceType);
        columns = new List<SelectOption>();
        columns = dataSource.getColumns();
        plManager = Utils_Factory.getPickListManager(interfaceType);        
        if(plManager != null)
        {
            Labels = plManager.getPickListLabels();
            items1 = plManager.getPicklistValues(1, null);
            if(items1!=null)
            items2 = plManager.getPicklistValues(2,Level1);
        }
        fetchedRecords = new List<DataTemplate__c>();
        System.Debug('****** Initializing the Properties and Variables Ends for VFC67_SolnOrSelnCenterSearch******');        
    }             
    
    Public PageReference  search() 
    {     
    /* This method will be called on click of "Search" Button.This method calls the factory methods
     * and fetches the search results
     */
       System.Debug('****** Searching Begins  for products******');
        if(resultsController.searchResults!=null)
            resultsController.searchResults.clear();
        fetchedRecords.clear();
        keywords = new List<String>();
        filters = new List<String>();
        if(searchController.searchText!=null)
            searchKeyword = searchController.searchText.trim();
        if(searchKeyword != null)
            keywords = searchKeyword.split('\\s');    
        if(searchController.level1!=null)
            filters.add(searchController.level1);
        if(searchController.level2!=null)
            filters.add(searchController.level2); 
        system.debug('----filters-----'+filters);
        system.debug('----keywords -----'+keywords );  
        if(keywords.size()!=0 || filters.size()!=0)
        {
            if(((!filters.ISEmpty()) && filters[0] != Label.CL00012) || ((!keywords.ISEmpty())&& keywords[0].length()>0))
            {
                try
                {
                    System.debug('#### Filters : ' + filters);
                    System.debug('#### keywords : ' + keyWords);
                    //Makes the Datasource call for search                    
                    searchResult = dataSource.Search(keywords,filters);
                    fetchedRecords = searchResult.recordList;
                    System.debug('Data source Result'+fetchedRecords);
                    System.debug(' Result'+searchResult);
                    DisplayResults = true;
                    
                    if(searchResult.NumberOfRecord > Integer.ValueOf(Label.CL00013))
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Info,Label.CL00021+' '+Label.CL00013));
                }
                catch(Exception exc)
                {
                    system.debug('Exception while calling Search '+ exc.getMessage() );
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.error,Label.CL00022));
                    displayError=true;
                }                
            }
            else if(filters[0].equalsIgnoreCase(Label.CL00012) && keywords[0].length()==0)
            {
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.error,Label.CL00023));
            }             
        }        
        System.Debug('****** Searching Ends  for products******');        
        return null;          
    }
    /* This method will be called on click of "Clear" Button.This method clears the value in the search text box
     * and the values in picklists
     */
    Public PageReference clear() 
    {
        System.Debug('****** clearing the value in the search text box,picklists & Search Text Begins  for VFC67_SolnOrSelnCenterSearch******');     
        fetchedRecords = new List<DataTemplate__c>();
        searchKeyword = null;
        keywords = new List<String>();
        filters = new List<String>();        
        searchController.init();
        DisplayResults = false;
        System.Debug('****** clearing the value in the search text box,picklists & Search Text Ends for VFC67_SolnOrSelnCenterSearch******');     
        return null;
    }
    /* This method will be called from the component controller on click of "Select" link.
     */
     public override pagereference PerformAction(sObject obj, VFC_ControllerBase controllerBase)
     {
        System.Debug('****** Insert Of Account Product Begins******');        
        accountProduct thisController = (accountProduct)controllerBase;                
        PageReference pg;     
        if(system.currentpagereference().getParameters().get(label.CL00009)!=null)
        {
            accId = system.currentpagereference().getParameters().get(label.CL00009);        
        }              
        if(prods!=null)
            prods = (DataTemplate__c)obj;        
        AccountProduct__c accprods = new AccountProduct__c();    
        if(prods!=null)
        {
            if(prods.Field4__c!=null)
                accprods.Product__c = prods.Field4__c;
            if(prods.Field2__c!=null)        
                accprods.Business__c= prods.Field2__c;
            if(prods.Field3__c!=null)        
                accprods.ProductFamily__c= prods.Field3__c; 
            if(accId!=null)
                accprods.account__c=accid;                                               
        }  
        if(accprods!=null)
        {                    
            Database.saveResult sv = Database.insert(accprods,false);
            if(!sv.issuccess())
            {
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error,sv.getErrors()[0].getmessage()));
            }
            
        }
        if(accprods.id!=null)                   
            pg = new pagereference('/'+accprods.id);
        return pg;
    }    
}