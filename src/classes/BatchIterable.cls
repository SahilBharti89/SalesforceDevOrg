global class BatchIterable implements Database.Batchable<Account> {
	
	public Iterable<Account> start(Database.BatchableContext bc) {
		List<Account> accList = new List<Account>();
		accList = [Select Id,Name From Account Limit 10];
		return accList;
	}
	
	public void execute(Database.BatchableContext bc,List<Account> accountsList) {
		
		for(Account acc : accountsList) {
			System.debug('Id :'+acc.Id+'Name :'+acc.Name);
		}
	}
    
    public void finish(Database.BatchableContext bc) {
    	System.debug('Account processed successfully');
    }
}