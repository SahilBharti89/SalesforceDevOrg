public with sharing class WinningOppChecker {
    
    Map<Id,Opportunity> oldOpps;
    Map<Id,Opportunity> newOpps;
    
    public WinningOppChecker(Map<Id,Opportunity> oldOpps, Map<Id,Opportunity> newOpps) {
    	this.oldOpps = oldOpps;
    	this.newOpps = newOpps;
    }
    
    public void checkWinningOpps(){
    	for(Opportunity newOpp : newOpps.values()) {
    		Opportunity oldOpp = oldOpps.get(newOpp.Id);
    		Boolean oldOppIsWon = oldOpp.StageName.equals('Closed Won');
			Boolean newOppIsWon = newOpp.StageName.equals('Closed Won');
			
			if(!oldOppIsWon && newOppIsWon) {
				newOpp.Closed_Won_Check__c = true;
			}
    	}
    }
}