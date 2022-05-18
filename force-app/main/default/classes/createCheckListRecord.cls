public with sharing class createCheckListRecord {

    @Auraenabled
    public static string createChecklist(Checklist__c chlObj)
    {
        insert chlObj;
        return chlObj.Id;
    }
    @Auraenabled
    public static List<Checklist__c> retrieveChecklist()
    {
        return [SELECT Name, type__c FROM Checklist__c];
    }
}