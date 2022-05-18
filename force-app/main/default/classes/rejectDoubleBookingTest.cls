@isTest
public class rejectDoubleBookingTest 
{
 //positive scenario
 static testmethod void singleBookingTest()
 {
     Datetime now = system.now();
     Speaker__c objTestSpeaker = new Speaker__c(First_Name__c='John',Last_Name__c='Smith');
     insert objTestSpeaker;
     Session__c objTestSession = new Session__c(Name='Test Session',Session_Date__c=now);
     insert objTestSession;
     Session_Speaker__c  objTestSpeakSes = new Session_Speaker__c (Session__c = objTestSession.Id ,Speaker__c = objTestSpeaker.Id);
     Test.startTest();
     Database.SaveResult result = Database.insert(objTestSpeakSes,false);
     Test.stopTest();
     system.assert(result.isSuccess());
 }
    //negative scenario
 static testmethod void doubleBookingTest()
 {
     Datetime now = system.now();
     List<Session__c> lstTestSessions = new List<Session__c>();
     Speaker__c objTestSpeaker = new Speaker__c(First_Name__c='John',Last_Name__c='Smith');
     insert objTestSpeaker;
     Session__c objTestSession1 = new Session__c(Name='testSession1',Session_Date__c=now);
     lstTestSessions.add(objTestSession1);
     Session__c objTestSession2 = new Session__c(Name='testSession2',Session_Date__c=now);
     lstTestSessions.add(objTestSession2);
     insert lstTestSessions;
     List<Session_Speaker__c> lstTestSpeakSes = new List<Session_Speaker__c>();  
     Session_Speaker__c  objTestSpeakSes1 = new Session_Speaker__c (Session__c = objTestSession1.Id ,Speaker__c = objTestSpeaker.Id);
     insert objTestSpeakSes1;
     Session_Speaker__c objTestSpeakSes2 = new Session_Speaker__c (Session__c = objTestSession2.Id ,Speaker__c = objTestSpeaker.Id);
     //lstTestSpeakSes.add(objTestSpeakSes1);
     //lstTestSpeakSes.add(objTestSpeakSes2);
     Test.startTest();
     //insert objTestSpeakSes2;
     system.debug('lstTestSpeakSes:::::::::::'+lstTestSpeakSes);
     Database.SaveResult result= Database.insert(objTestSpeakSes2, false);
     Test.stopTest();
    if(result!= null)
     {
       
            system.assert(!result.isSuccess());
     
    }
 }
}