trigger rejectDoubleBooking on Session_Speaker__c (before insert,before update) 
{
    //variaiable declaration
    set<Id> speakerIds = new set<Id>();
    Map<Id,DateTime> requestedBookings = new Map<Id,DateTime>();
    //collecting Ids
    for(Session_Speaker__c objSessionSpeaker : Trigger.New)
    {
        speakerIds.add(objSessionSpeaker.Speaker__c);
        system.debug('speakerIds_::::::::'+speakerIds);
        requestedBookings.put(objSessionSpeaker.Session__c,null);
    }
    //fill out the start date/time for the related sessions
    List<Session__c> related_sessions = [SELECT ID, Session_Date__c from Session__c WHERE ID IN :requestedBookings.keySet()];
    for(Session__c related_session : related_sessions) {
        requestedBookings.put(related_session.Id,related_session.Session_Date__c);
    }
    //get related speaker sessions to check against
    List<Session_Speaker__c> related_speakers = [SELECT ID, Speaker__c, Session__c, Session__r.Session_Date__c from Session_Speaker__c WHERE Speaker__c IN :speakerIds];

    //check one list against the other
    for(Session_Speaker__c requested_session_speaker : trigger.new) {
        DateTime booking_time = requestedBookings.get(requested_session_speaker.Session__c);
        for(Session_Speaker__c related_speaker : related_speakers) {
            if(related_speaker.Speaker__c == requested_session_speaker.Speaker__c &&
               related_speaker.Session__r.Session_Date__c == booking_time) {
                   requested_session_speaker.addError('The speaker is already booked at that time');
               }
        }
    }
}