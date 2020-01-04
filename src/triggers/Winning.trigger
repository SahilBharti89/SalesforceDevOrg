trigger Winning on Opportunity (before update) {
    
    for(Opportunity opp : Trigger.New) {
        Opportunity oldOpp = Trigger.oldMap.get(opp.Id);
        Boolean oldOppIsWon = oldOpp.StageName.equals('Closed Won');
        Boolean newOppIsWon = opp.StageName.equals('Closed Won');
        if(!oldOppIsWon && newOppIsWon) {
            opp.Closed_Won_Check__c = true;
        }
    }
    
}