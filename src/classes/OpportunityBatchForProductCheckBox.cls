global class OpportunityBatchForProductCheckBox implements Database.Batchable<sObject> {
    global Database.QueryLocator start(Database.BatchableContext bc){
        String query = 'Select Id,Name From Opportunity where Id in(Select OpportunityId From OpportunityLineItem)';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc,List<Opportunity> opps) {
        List<Opportunity> oppListUpdate = new List<Opportunity>();
        for(Opportunity op : opps) {
            op.Has_Product__c = true;
            oppListUpdate.add(op);
        }
        update oppListUpdate;
    }
    
    global void finish(Database.BatchableContext bc){
        System.debug('Task Updated Successfully!');
    }
}