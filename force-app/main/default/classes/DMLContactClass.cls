public class DMLContactClass
{
    
                                
    //Database.SaveResult[] srList = Database.insert(lstContacts,false);
   public static void insertClass()
   {
   List<Contact> lstContacts = new List<Contact>{
                                new Contact(FirstName='Joe',LastName='Smith',Department='Finance'),
                                new Contact(FirstName='Kathy',LastName='Smith',Department='Technology'),
                                new Contact(FirstName='Caroline',LastName='Roth',Department='Finance'),
                                new Contact()};
    
    Database.SaveResult[] srList = Database.insert(lstContacts, false);
   //
    for(Database.SaveResult sr :srList)
    {
        if(sr.isSuccess())
        {
            system.debug('Successfully inserted contact. Contact ID: '+sr.getId());
        }
        else
        {
            for(Database.Error er: sr.getErrors())
            {
                System.debug('The following error has occurred.');
                System.debug(er.getStatusCode() + ': ' + er.getMessage());
                System.debug('Contact fields that affected this error: ' + er.getFields());
            }
        }
    }
    }
}