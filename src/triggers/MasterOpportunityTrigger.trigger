trigger MasterOpportunityTrigger on Opportunity (after delete, after insert, after update, before delete, before insert, before update) {
    
    if(Trigger.isBefore) {
    	if(Trigger.isInsert) { }
    	if(Trigger.isUpdate) {
    		WinningOppChecker checker = new WinningOppChecker(Trigger.oldMap,Trigger.newMap);
    		checker.checkWinningOpps();
    	}
    	
    	if(Trigger.isDelete) {}
    }
    
    if(Trigger.isAfter) {
    	if(Trigger.isInsert) { }
    	if(Trigger.isUpdate) { }
    	
    	if(Trigger.isDelete) {}
    }
}