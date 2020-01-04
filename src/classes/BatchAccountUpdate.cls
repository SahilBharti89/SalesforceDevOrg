global class BatchAccountUpdate implements Database.Batchable<sObject> {
    global Database.QueryLocator start(Database.BatchableContext bc) {
        String query = 'Select Id, Name From Account';
        return Database.getQueryLocator(query);
    }
	
    global void execute(Database.BatchableContext bc, List<Account> accList) {
        for(Account acc : accList) {
           // acc.Name = acc.Name + 'Ryaan';
        }
        try{
            update accList;
        }catch(Exception e){
            System.debug(e);
        }
    }
    
    global void finish(Database.BatchableContext bc) {
        System.debug('Account updated Successfully!');
    }
}