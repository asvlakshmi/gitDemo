Public class AccountHandler
{
    Public Static Account insertNewAccount(String str)
    {
        if(!String.isEmpty(str))
        {
            Account objAcc = new Account(); 
            objAcc.Name= str;
             insert objAcc;
             return objAcc;
        }
        else
        {
            return null;
        }
    }
}