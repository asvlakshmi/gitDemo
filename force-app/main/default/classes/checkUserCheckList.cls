public with sharing class checkUserCheckList {
     @Auraenabled
    public static string createChecklist(Checklist__c chlObj)
    {
        insert chlObj;
        return chlObj.Id;
    }
    
    
    @AuraEnabled
    public static CheckListHeader__c getCheckListHierarchy(){
        return CheckListHeader__c.getInstance();
    }
    
     @AuraEnabled
    public static String updateCheckListHierarchy(CheckListHeader__c checkListHeader){
        CheckListHeader__c updateCheckListHeader = new CheckListHeader__c(Id=(String)checkListHeader.get('Name'), CheckList_Header_Name__c=(String)checkListHeader.get('CheckList_Header_Name__c'));
        update updateCheckListHeader;
        return 'success';
    }
    
     @AuraEnabled
    public static List<Checklist__c> getcheckList() {
        List<Checklist__c> newList = new List<Checklist__c> ();
        newList =  [SELECT Id,Name, type__c,ownerId FROM Checklist__c WHERE ownerId = :userInfo.getUserId() limit 1];
        return newList;
    }
     @AuraEnabled
    public static List<Checklist_Item__c> getcheckListItem() {
        List<Checklist_Item__c> newcheckList = new List<Checklist_Item__c> ();
        newcheckList =  [SELECT Id, Name,Checklist__c,Description__c,Status__c FROM Checklist_Item__c WHERE Checklist__r.ownerId = :userInfo.getUserId()];
        
       system.debug('newcheckList::::::::'+newcheckList);
        return newcheckList;
    }
	 @AuraEnabled
    public static void saveCLI( List<Checklist_Item__c> items) {
        
    System.debug(items);
        update items;
    }	
}