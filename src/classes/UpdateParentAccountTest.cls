@IsTest
public class UpdateParentAccountTest {
    @testSetup
    static void setup() {
        List<Account> accounts = new List<Account>();
        accounts.add(new Account(name = 'Parent'));
        for(Integer i=0;i<100;i++) {
            accounts.add(new Account(name = 'Test Account'+i));
        }
        insert accounts;
    }
    
    static testmethod void testQueueable() {
        Id parentId = [Select Id From Account where Name = 'Parent'][0].Id;
        List<Account> accounts = new List<Account>([Select Id, Name From Account where Name like 'Test Account%']);
        UpdateParentAccount updater = new UpdateParentAccount(accounts,parentId);
        
        Test.startTest();
        System.enqueueJob(updater);
        Test.stopTest();
        
        System.assertEquals(100, [Select count() From Account where parentId =: parentId]);
    }

}