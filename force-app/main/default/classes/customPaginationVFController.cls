public with sharing class customPaginationVFController {

    public Boolean getHasNext() 
    {
        if(this.page<this.totalPages){
            return true;
        }
        else{
            return false;
        }
    }


    public void doNext() {
        if(getHasNext()){
            this.page++;
            getContacts();
        }
    }


    public Boolean getHasPrevious() 
    {
        if(this.page>1){
            return true;
        }
        else{
            return false;
        }
    }


    public void doPrevious() 
    {
         if(getHasPrevious()){
            this.page--;
            getContacts();
        }
    }


    public List<CCRow> listContacts { get; set; }
    //default page size
    private static final Integer PAGE_SIZE = 10;
    
    
    //pagination information
    public Integer page{get;set;}
    public Integer totalRecords{get;set;}
    public Integer totalPages{get;set;}
    
    public customPaginationVFController()
    {
        this.listContacts  = new List<CCRow>();
        this.page = 1;
        getContacts();
    }
    public void getContacts()
    {
        this.totalRecords = 0;
        
        //clear container for records displayed
        this.listContacts.clear();
        for(Contact objContact:[SELECT Id, FirstName, LastName, Title, Phone, MobilePhone, Email, 
                                MailingStreet, MailingState, MailingPostalCode, MailingCountry, MailingCity 
                                FROM Contact 
                                ORDER BY LastName ASC 
                                LIMIT 50000])
         {
             this.listContacts.add(new CCRow(objContact,false));
             this.totalRecords++;
         }
         system.debug('totalRecords:::::::::'+this.totalRecords);
         //calculate total pages
        Decimal pages = Decimal.valueOf(this.totalRecords);
        pages = pages.divide(Decimal.valueOf(PAGE_SIZE), 2);
        this.totalPages = (Integer)pages.round(System.RoundingMode.CEILING);
        system.debug('totalpages:::::::::'+this.totalPages);
    }
    //system.debug(totalpages:::::::::,'+this.totalPages');
    public with sharing class CCRow
    {
        public Contact tContact{get;set;}
        public Boolean isSelected{get;set;}
        public CCRow(Contact con,Boolean s)
        {
            tContact = con;
            isSelected = s;
        }
    }
    
}