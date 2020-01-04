public class AcWithContacts {
    public List<wrapAccount> wrapAccountList {get; set;}
    //public List<Account> selectedAccounts {get; set;}
    public List<wrapContact> wrapcontactList {get; set;}
    
    public AcWithContacts(){
        if(wrapAccountList == null){
            wrapAccountList = new List<wrapAccount>();
            wrapcontactList = new List<wrapContact>();
            for(Account a: [Select Id, Name,BillingState,Website,Phone From Account]){
                wrapAccountList.add(new wrapAccount(a));
            }
            for(Contact cn: [Select Name From Contact where AccountId in (Select Id From Account)]){
                wrapcontactList.add(new wrapContact(cn));
            }
        }
    }
    
   /* public void processSelected(){
        selectedAccounts = new List<Account>();
        for(wrapAccount wrapAccountObj : wrapAccountList){
            if(wrapAccountObj.selected == true){
                selectedAccounts.add(wrapAccountObj.acc);
            }
        }
    } */
    
    public class wrapAccount {
        public Account acc {get; set;}
        public Boolean selected {get; set;}
        
        public wrapAccount(Account a){
            acc = a;
            selected = false;
        }
    }
    public class wrapContact {
        public Contact ct {get; set;} 
        public Boolean cselect {get; set;}
        
        public wrapContact(Contact c){
            ct=c;
            cselect = false;
        }
    }

}