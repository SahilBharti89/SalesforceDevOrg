trigger AccountDeletion on Account (before delete) {
    for(Account a : [Select Id From Account 
                    where Id IN (Select AccountId From Opportunity) AND 
                     Id IN : Trigger.Old]) {
                         Trigger.OldMap.get(a.Id).addError(
                             'Cannot delete account with related opportunities.');
                     }

}