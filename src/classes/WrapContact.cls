public class WrapContact {
    public List<wrContact> wrContactList {get; set;}
    public List<Contact> selectedContactLists {get; set;}
    
    public WrapContact(){
        if(wrContactList == null){
            wrContactList = new List<wrContact>();
            for(Contact c : [Select Name, Email, Phone, Account.Name From Contact]){
                wrContactList.add(new wrContact(c));
            }
        }
    }
    
    public void allSelected(){
		selectedContactLists = new List<Contact>();  
        for(wrContact wrObj : wrContactList){
            if(wrObj.selected == true){
                selectedContactLists.add(wrObj.con);
            }
        }
    }
    
    public class wrContact {
        public Contact con {get; set;}
        public Boolean selected {get; set;}
        
        public wrContact(Contact con){
            this.con=con;
            selected=false;
        }
    }

}