public class ContactDetails {
    public List<wrapContact> wrapcontactList {get; set;}
    public List<Contact> selectedContacts {get; set;}
    public Boolean mainBoxValue {get; set;}
    public string AccId;
    
    public ContactDetails(ApexPages.StandardController ctrl ) {
        
        wrapcontactList = new List<wrapContact>();
        AccId = ApexPages.currentPage().getParameters().get('id');
        for(Contact cn: [Select Id,Name, Email, Phone, Department,BirthDate From Contact where AccountId =: AccId ]){
            wrapcontactList.add(new wrapContact(cn,false));
        }
        
    }
    public void checkAll(){
        for(wrapContact wrOBjj : wrapcontactList) {
            wrOBjj.isSelect = mainBoxValue;
            System.debug('Check All'+wrOBjj);
        }
    }
    public void processSelected() {
        selectedContacts = new List<Contact>();
        for(wrapContact wrapObj : wrapcontactList ) {
            if(wrapObj.isSelect == true) {
                selectedContacts.add(wrapObj.cont);
                System.debug('Selected Process'+wrapObj);
            }
        }
    }
    public class wrapContact {
        public Contact cont {get; set;} 
        public Boolean isSelect {get; set;}
        
        public wrapContact(Contact cont , Boolean isSelect ){
            this.cont = cont ;
            this.isSelect = isSelect;
        }
    }
    
}