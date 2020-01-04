public class SubSearchController {

    public String Id {get;set;}
    public String Name {get;set;}
    public Integer phone {get;set;}
    public String website {get;set;}
    
    public List<Account> records {get; private set;}
    
    public SubSearchController(){
        records = new List<Account>();   
    }
    
    public PageReference searchRecords() {
        
        records = [SELECT Name, Id, Phone, Website FROM Account];
        return null;
        
    }
    
}