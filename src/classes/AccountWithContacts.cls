public class AccountWithContacts {
    public static void show()
    {  
/*        List<Contact> conList = new List<Contact>([SELECT AccountId,Account.Name,Account.Phone,Account.Id,FirstName, LastName, Phone From Contact]);
        Map<Account,List<Contact>> accountContactMap = new Map<Account,List<Contact>>();
        for(Contact con : conList){
            if(accountContactMap.containsKey(con.Account)){
                accountContactMap.get(con.Account).add(con);
            }else{
                List<Contact> clist = new List<Contact>();
                clist.add(con);
                accountContactMap.put(con.Account,clist);
            }
        }
        
        System.debug(accountContactMap.keySet());
        System.debug(accountContactMap.values());
        
        for(Account key : accountContactMap.keySet()){
            Contact[] cnct = accountContactMap.get(key);
            System.debug('Key :'+key);
            System.debug('Values :'+JSON.serializePretty(cnct));
        }
        */
        
        
        
		Map<Id,List<Contact>> accountContactMap = new Map<Id,List<Contact>>();
		List<Account> lstAccount = [SELECT Name, (SELECT Name FROM Contacts) FROM Account];
		for(Account acc : lstAccount)
        {
            accountContactMap.put(acc.id, acc.Contacts);
        }
        for(Id i : accountContactMap.keySet())
        {
            System.debug('Account Id : '+i+' Contacts : '+accountContactMap.get(i));
        }
        //System.debug(accountContactMap);
        
    }

}