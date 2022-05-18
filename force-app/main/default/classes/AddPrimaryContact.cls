public class AddPrimaryContact implements Queueable 
{
    private Contact objContact;
    private String state;
    public AddPrimaryContact(contact objCon,string str)
    {
        this.objContact = objCon;
        this.state = str;
    } 
    public void execute(QueueableContext context)
    {
        List<Account> lstAccounts = [select Id,Name from Account where Billingstate =: state limit 200];
        List<contact> lstContact = new List<contact>();
        for(Account objAcc: lstAccounts)
        {
            contact con = objContact.clone(false,false,false,false);
            con.accountId = objAcc.Id;
            lstContact.add(con);
        }
        if(lstContact!=null && lstContact.size()>0)
        {
            insert lstContact;
        }
    }
    
}