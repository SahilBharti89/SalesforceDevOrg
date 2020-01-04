@isTest
public with sharing class TestContactCount {
    
  /*  @isTest static void TestContactTrigger() {
    	Contact cont=new Contact(LastName='Noam');
    	insert cont;
    	
    	Test.startTest();
    	Database.SaveResult result = Database.insert(cont,false);
    	Test.stopTest();
    	
    }
    @isTest static void TestContactTrigger1() {
    	Contact cont=new Contact(LastName='Noam');
    	insert cont;
    	
    	Test.startTest();
    	Database.DeleteResult result = Database.delete(cont,false);
    	Test.stopTest();
    	
    }*/
    
    @isTest static void TestContactTrigger2() {
        Account a = new Account();
        a.Name='Test Abc';
        insert a;
        
    	Contact cont=new Contact();
        cont.LastName='Noam';
        cont.AccountId=a.Id;
    	insert cont;
    	update cont;
        delete cont;
    	
    }
}