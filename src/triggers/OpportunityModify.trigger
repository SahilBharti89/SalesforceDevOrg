trigger OpportunityModify on Opportunity (before insert, before update ) {
    Set<String> accountIdSet = new Set<String>();
    if(Trigger.isInsert || Trigger.isUpdate) {
        for(Opportunity opp : Trigger.New) {
            accountIdSet.add(opp.AccountId);
        }
    }
    
    if(accountIdSet != null || !accountIdSet.isEmpty()) {
       Map<String,String> accountIdWithNameMap = new Map<String,String>();
       for(Account acc : [Select Id,Name From Account where Id in : accountIdSet]) {
       	accountIdWithNameMap.put(acc.Id,acc.Name);
       }
        for(Opportunity op : Trigger.New) {
        	if(accountIdWithNameMap != null && !accountIdWithNameMap.isEmpty() && 
        		accountIdWithNameMap.containskey(op.AccountId)) {
        			op.Name = accountIdWithNameMap.get(op.AccountId) + op.StageName;
		            System.debug('Opp Name : '+op.Name);
        		}
            
        }
		
    }
    
}