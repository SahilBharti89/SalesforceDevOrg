trigger SoqlTriggerBulk on Account (after update) {
     List<Account> acctWithOpps = 
         [Select Id,Name,(Select Id,Name,CloseDate From Opportunities)
                                 From Account where Id IN : Trigger.New];
    for(Account a : acctWithOpps) {
        Opportunity[] relatedOpps = a.Opportunities;
    }

}