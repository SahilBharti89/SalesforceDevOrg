global class FullCalendarDemoController {
    
    @RemoteAction
    global static List<User_Calendar__c> getEvents() {
        String userId = UserInfo.getUserId() ;
        List<User_Calendar__c> userCalendar = [SELECT Id, Name, User__r.Name,Event__c, Event__r.Name, Event__r.Start_Time__c, Event__r.End_Time__c
                                               FROM User_Calendar__c  WHERE User__c=:userId];
        if(userCalendar.size()>0){
	        return userCalendar;
        } else{
            return null;
        }
    }
    
    @RemoteAction
    global static List<User_Calendar__c> createOrUpdatesEvents(String calendarEvent) {
    	
    	Calender__c eventObject = ((Calender__c) JSON.deserialize(calendarEvent,Calender__c.class));
    	Boolean isOldRecord = eventObject.Id != null;
    	upsert eventObject;
    	
    	if(!isOldRecord) {
    		User_Calendar__c userCalendar = new User_Calendar__c(Event__c = eventObject.Id, User__c = UserInfo.getUserId());
    		insert userCalendar;
    	}
    	return getEvents();
    }
}