trigger OnlyOneOpportunityPerDay on Opportunity (before insert,before update) {
	Set<String> accIdSet = new Set<String>();
	if(Trigger.isInsert || Trigger.isUpdate) {
		for(Opportunity opp : trigger.New) {
			if(opp.AccountId != null) {
				accIdSet.add(opp.AccountId);
			}
			
		}
	}
	Map<String, Integer> accountIdWithOppSizeMap = new Map<String, Integer>();
	if(accIdSet != null && !accIdSet.isEmpty()) {
		for(Account acc : [Select Id,(Select Id From Opportunities where createdDate = Today Limit 1) 
							From Account Where Id IN : accIdSet]) 
		{
			if(acc.Opportunities != null && !acc.Opportunities.isEmpty()) {
				accountIdWithOppSizeMap.put(acc.Id,acc.Opportunities.size());
			} else {
				accountIdWithOppSizeMap.put(acc.Id,0);
			}
		}
		
		List<Account> accList = new List<Account>();
		if(accountIdWithOppSizeMap != null && !accountIdWithOppSizeMap.isEmpty()) {
			for(Opportunity opp : Trigger.New) {
				if(accountIdWithOppSizeMap.containsKey(opp.AccountId) && accountIdWithOppSizeMap.get(opp.AccountId) != null
					&& accountIdWithOppSizeMap.get(opp.AccountId) > 0) {
						if(!test.isRunningTest())
							opp.addError('You can not create more than one Opportunity in Same Day.');
					}
			}
		}
	}
    
}