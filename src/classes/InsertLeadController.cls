public class InsertLeadController {
   
    public lead l {get;set;}
        
    public InsertLeadController(){
        l= new lead();
    }
    
    public PageReference submitLead() {
        insert l;
        PageReference newPage = new PageReference('/'+l.Id);
        return newPage;
        
    }

}