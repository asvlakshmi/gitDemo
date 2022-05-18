Public class ContactAndLeadSearch
{
    public static List<List< SObject>> searchContactsAndLeads(string lstName)
    {
        List<List< SObject>> lstAccountsAndContacts = new List<List< SObject>>();
        lstAccountsAndContacts = [find :lstName IN Name Fields Returning Lead(Name), Contact(FirstName,LastName,Department)];
        system.debug('lstAccountsAndContacts::::::::::::::::'+lstAccountsAndContacts);
        return lstAccountsAndContacts;
    }
}