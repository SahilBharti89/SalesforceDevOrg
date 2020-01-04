public class OpportunityCount {
    public void countOpp()
    {
        List<Account> opplist = new List<Account>();
        for(Account a : [Select Id, Opportunity_Count__c, (Select Id from Opportunities) From Account])
        {
            System.debug('Account '+a);
            a.Opportunity_Count__c = a.Opportunities.size();
            opplist.add(a);
        }
        update opplist;
    }

}