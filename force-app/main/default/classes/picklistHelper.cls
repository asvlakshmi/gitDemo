/**
 * Class Name:picklistHelper 
 * Developer: initial Development by Lakshmi 
 *  
 
 * */

public with sharing class picklistHelper {
    public picklistHelper() {

    }
    @AuraEnabled(cacheable=true)
    public static Map<string,EmailTemplate> getEmailTemplates()
    {
        Map<string,EmailTemplate> mapEmailTemplates = new Map<string,EmailTemplate>();
        for(EmailTemplate objEmailTemplate:[select Id,Name,body from EmailTemplate limit 10])
        {
            mapEmailTemplates.put(objEmailTemplate.Id,objEmailTemplate);
        }
        system.debug('mapEmailTemplates:::::::::'+mapEmailTemplates.size());
        return mapEmailTemplates;
    }
    @AuraEnabled
    public static void SendEmail(List<id> lvIds,string selectedET) {
        system.debug('ListofIds:::::::::'+lvIds);
        try{ 
            Messaging.MassEmailMessage mail = new Messaging.MassEmailMessage();
            mail.setTargetObjectIds(lvIds);
            mail.setSenderDisplayName('System Admin');
            mail.setTemplateId(selectedET);
            List<Messaging.SendEmailResult> results = Messaging.sendEmail(new Messaging.MassEmailMessage[] { mail });
            system.debug('Results:::::::::'+results);
        }catch(Exception ex){
            throw new AuraHandledException(ex.getMessage());
        }

       }
}