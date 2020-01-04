public with sharing class AccountWithContact {
	public Map<Id,List<Contact>> acWithCont {get;set;}
	
	public AccountWithContact(){
		acWithCont = new Map<Id,List<Contact>>();
		for(Account acc : [Select Name,(Select LastName from Contacts) from Account Limit 10]) {
			if(!acc.Contacts.isEmpty()){
				acWithCont.put(acc.Id,acc.Contacts);
			}
		}
	}
    
}