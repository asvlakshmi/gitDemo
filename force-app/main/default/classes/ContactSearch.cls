public class ContactSearch
{
    public static List<Contact> searchForContacts( String lstName,String postalCode)
    {
        List<Contact> lstContact = new List<Contact>();
        lstContact =[select Id,Name from Contact where LastName =:lstName and MailingPostalCode =:postalCode];
        return lstContact;
    }
}