public with sharing class wrapperclass {
    private final string oppId;
    private final opportunity opp;
    public List<contact> lstContacts = new List<contact>();
    public List<Account> lstAccounts = new List<Account>();
   
    public wrapperclass(ApexPages.StandardController controller) {
        oppId = apexpages.currentpage().getparameters().get('id');
        if(oppId !=null)
        {
            opp = [select Id,Name from opportunity where Id = :oppId ] ;
        }

    }
    //public List<Contact> contacts {get;set;}
    //public List<Account> accountLists{get;set;}
    public List<contact> getcontactLists()
    {
       
        //lstContacts = new List<contact>();
        lstContacts = [select Id,Name,Email,Phone from contact order by Name limit 10];
        //System.debug('The value is: ' + lstContacts);
        return lstContacts;
    }
    //System.debug('The value is: ' + lstContacts);
    //system.debug(lstContacts::::::::::::'+lstContacts' );
    public List<Account> getaccountLists()
    {
        //List<Account> lstAccounts = new List<Account>();
        lstAccounts = [select Id,Name,Phone from Account order by Name limit 10];
        return lstAccounts;
    }

}