public class MultipleRecords {
    Account account = new Account();
    public List<Account> listAccount {get; set;}
    
    public MultipleRecords() {
        listAccount = new List<Account>();
        listAccount.add(account);
        
    }
    
    public void addAccount() {
        Account acc = new Account();
        listAccount.add(acc);
    }
    
    public void deleteAccount() {
        //Account acc = new Account();
        listAccount.remove(0);
    }
    public PageReference saveAccount() {
        for(Integer i=0;i<listAccount.size();i++) {
            insert listAccount;
        }
        System.debug('listAccount : '+listAccount);
        //PageReference newPage = new PageReference('/'+listAccount[0].id);
		//return newPage;
        return Page.Allaccountssaved;
    }

}