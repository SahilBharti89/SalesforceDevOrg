trigger CloseDateInFuture on Opportunity (before insert,before update) {
   //Set<String> accountIdSet = new Set<String>();
    if(Trigger.isInsert || Trigger.isUpdate) {
        for(Opportunity opp : Trigger.New) {
        	if(opp.closeDate < Date.valueof(DateTime.now())) {
    				opp.addError('Close Date must be in Future.');
    			}
           // accountIdSet.add(opp.AccountId);
        }
    } 
    
   /* if(accountIdSet != null || !accountIdSet.isEmpty()) {
    	for(Opportunity opp : [Select Id,AccountId,CloseDate From Opportunity Where AccountId 
    							IN :  accountIdSet])
    	{
    		System.debug('ioioko,'+opp.closeDate +'  '+ Date.valueof(DateTime.now()));
    		for(Opportunity op : Trigger.New) {
    			if(opp.closeDate < Date.valueof(DateTime.now())) {
    				op.addError('Close Date must be in Future.');
    			}
    		}
    		
    	}
    } */
}