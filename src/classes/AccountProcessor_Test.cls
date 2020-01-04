@isTest
private class AccountProcessor_Test {
    public static testmethod void TestAccountProcessorTest() {
        Account a = new Account();
        a.Name = 'GenePoint';
        Insert a;
        
        Contact cont = new Contact();
        cont.FirstName = 'Edna';
        cont.LastName = 'Frank';
        cont.AccountId = a.Id;
        Insert cont;
        
        Set<Id> setAccId = new Set<ID>();
        setAccId.add(a.Id); 
        
        test.startTest();
          AccountProcessor.countContacts(setAccId);
        test.stopTest();
        
        Account acc = [Select  Number_of_Contacts__c, (select id from contacts) from Account where Id =: a.id limit 1];
    	System.assertEquals(Integer.valueOf(acc.Number_of_Contacts__c), 1);
    }

}