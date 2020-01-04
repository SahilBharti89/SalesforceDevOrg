public class AccountProcessor {
  @future
  public static void countContacts(Set<Id> accIds) {
    List<Account> accountsList = new List<Account>();
      for(Account acc : [select  Number_of_Contacts__c, (select id from contacts) from Account where Id =: accIds]) {
      {
          acc.Number_of_Contacts__c = acc.contacts.size();
          accountsList.add(acc);
      }  
     update accountsList;
   }
}
}