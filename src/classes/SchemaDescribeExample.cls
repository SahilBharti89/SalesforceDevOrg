public with sharing class SchemaDescribeExample {
	public List<SelectOption> options;
	
    public List<SelectOption> getoptions() {
    	return options;
    }
    
    public SchemaDescribeExample() {
    	options = new List<SelectOption>();
    	Map<String,Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
    	Set<String> objectSet = schemaMap.keySet();
    	for(String str : objectSet) {
    		SelectOption op = new SelectOption(str,str);
    		options.add(op);
    	}
    }
}