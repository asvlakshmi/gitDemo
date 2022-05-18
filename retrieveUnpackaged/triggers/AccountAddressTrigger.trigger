trigger AccountAddressTrigger on Account (before insert,before update) 
{
    for(Account objAcc :Trigger.new)
    {
        if(objAcc.Match_Billing_Address__c == true && objAcc.BillingPostalCode!=null)
        {
            objAcc.ShippingPostalCode = objAcc.BillingPostalCode;
        }
    }

}