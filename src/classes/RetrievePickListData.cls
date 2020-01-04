public with sharing class RetrievePickListData {
    
    public List<SelectOption> getPickNames() {
    	Set<String> objectSet = new Set<String>();
    	List<SelectOption> options = new List<SelectOption>();
    	Schema.DescribeFieldResult ccity = 
    	Schema.SObjectType.Opportunity.fields.StageName.getSObjectField().getDescribe();
    	options.add(new SelectOption('--None--','--None--'));
    	for(PickListEntry ent : ccity.getPickListValues()) {
    		options.add(new SelectOption(ent.getValue(),ent.getLabel()));
    		objectSet.add(ent.getValue());
    	}
    	System.debug('objectSet'+objectSet);
    	return options;
    }
}