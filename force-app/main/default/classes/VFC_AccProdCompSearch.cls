/* Author- Abhishek Yadav
Creation Date - 20/03/2012
Description - Competitor Search Page */

public class VFC_AccProdCompSearch extends VFC_ControllerBase{
    private APC__c apc;
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
    public String level1Label{set; get{return Labels[0];}}      
    public Boolean displayError{get;set;}
    Public List<String> Labels{get;set;}
    public List<SelectOption> items1{set; get;}
    private DataTemplate__c competitor = New DataTemplate__c();
    public String fieldName{get;set;}  
    Private Boolean updtReq;      
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
    public VFC_AccProdCompSearch(ApexPages.StandardController controller)
    {
        System.Debug('****** Initializing the Properties and Variables Begins for VFC_CompetitorSearch******');            
        apc= (APC__c)controller.getRecord();  
        keywords = new List<String>();
        filters = new List<String>();
        columns = new List<SelectOption>();
        Labels = new List<String>();      
        displayError=false;                     
        interfaceType='COMP'; 
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
        }
        fetchedRecords = new List<DataTemplate__c>();
        System.Debug('****** Initializing the Properties and Variables Ends for VFC67_SolnOrSelnCenterSearch******');        
    }             
    
    public PageReference  search() 
    {     
    /* This method will be called on click of "Search" Button.This method calls the factory methods
     * and fetches the search results
     */
       System.Debug('****** Searching Begins  for VFC50_CompetitorSearch******');
    if(resultsController.searchResults!=null)
            resultsController.searchResults.clear();

        fetchedRecords.clear();
        keywords = new List<String>();
        filters = new List<String>();
        if(searchText!=null)
            keywords.add(searchText.trim());
        if(level1!=null)
            filters.add(level1);
        system.debug('----filters-----'+filters);
        system.debug('----keywords -----'+keywords );  
        if(keywords.size()!=0 || filters.size()!=0)
        {
            if(((!filters.ISEmpty()) && filters[0] != Label.CL00012) || ((!keywords.ISEmpty())&& keywords[0].length()>0))
            {
                try
                {
                    System.debug('#### Filters : ' + filters);
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
                    system.debug('Exception while calling Competitor Search '+ exc.getMessage() );
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.error,Label.CL00022));
                    displayError=true;                    
                }                
            }
            else if(filters[0].equalsIgnoreCase(Label.CL00012) && keywords[0].length()==0)
            {
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.error,Label.CL00023));

            }             
        }         
        System.Debug('****** Searching Ends  for VFC_CompetitorSearch******');        
        return null;          
    }
    /* This method will be called on click of "Clear" Button.This method clears the value in the search text box
     * and the values in picklists
     */
    public PageReference clear() 
    {
        System.Debug('****** clearing the value in the search text box,picklists & Search Text Begins  for VFC50_CompetitorSearch******');     
        fetchedRecords = new List<DataTemplate__c>();
        searchText = null;
        keywords = new List<String>();
        filters = new List<String>();        
        DisplayResults = false;
        level1 = null;
        System.Debug('****** clearing the value in the search text box,picklists & Search Text Ends for VFC50_CompetitorSearch******');     
        return null;
    }
   
    /* This method will be called from the component controller on click of "Select" link.
     */
     public override pagereference PerformAction(sObject obj, VFC_ControllerBase controllerBase)
     {
        System.Debug('****** Insert Of Account Product Begins******');        
        VFC_AccProdCompSearch thisController = (VFC_AccProdCompSearch)controllerBase;                
        PageReference pg;     
        string apId;
        If(system.currentpagereference().getParameters().get(label.CL00034)!=null)
        {
            apId = system.currentpagereference().getParameters().get(label.CL00035);        
        }              
        if(competitor!=null)
            competitor = (DataTemplate__c)obj;        
        APC__c accprods = new APC__c();    
        if(competitor!=null)
        {
            if(competitor.Field3__c!=null)
                accprods.Competitor__c = competitor.Field3__c;
            if(apId!=null)
                accprods.AccountProduct__c=apId;                                               
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
            pg = new pagereference('/'+apId);
        return pg;
    }    
}