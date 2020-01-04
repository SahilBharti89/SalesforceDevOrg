trigger ContactCount on Contact (after insert,after update,after delete) {
    
    Set<String> accountIdSet = new Set<String>();
    if(Trigger.isInsert || Trigger.isUpdate) {
        for(Contact con : Trigger.New) {
            accountIdSet.add(con.AccountId);
        }
        
        
    }
    
    if(Trigger.isDelete || Trigger.isUpdate) {  
        for(Contact con : Trigger.old) {
            accountIdSet.add(con.AccountId);
        }
        
    }
    
    if(accountIdSet != null  && !accountIdSet.isEmpty()) {
            List<Account> AccListUpdate = new List<Account>();
            for(Account acc : [Select Id,Name,(Select Id From Contacts) From Account Where Id IN : accountIdSet]) {
                
                acc.Contact_Count__c = acc.Contacts.size();
                AccListUpdate.add(acc);
            }
            if(AccListUpdate != null  && !AccListUpdate.isEmpty())
                update AccListUpdate;
        }
    
}