public class CountContacts {
    public CountContacts()
    {
        
    }
    public void countContact(){
        List<Account> accListToUpdate=new List<Account>();
        for(Account acc : [select id, Number_of_Contacts__c, (select id from contacts) from Account])
        {
            System.debug('acc'+acc);
            acc.Number_of_Contacts__c=acc.contacts.size();
            accListToUpdate.add(acc);
        }
        update accListToUpdate;
    }
    
    public void countContact(String val){
    
        Integer count=0;
        List<Account> accList=new List<Account>([select id, name, (select id, lastname from contacts) from Account where id=:val limit 1]);
        if(!accList.isEmpty()){
            count=accList[0].contacts.size();
        }
        accList[0].Number_of_Contacts__c=count;
        update accList;
        
    }

}