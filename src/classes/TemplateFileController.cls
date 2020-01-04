public with sharing class TemplateFileController {
    
    public Boolean render1 {get;set;}
	public List<EmailTemplate> tempfolders = new List<EmailTemplate>();
	public String searchValue {get; set;}
	public String foldId {get;set;}
	
	public TemplateFileController() {
		try {
			searchValue = ApexPages.currentPage().getParameters().get('parentname');
			 foldId = ApexPages.currentPage().getParameters().get('parentid');
			if(String.isNotBlank(searchValue)) {
				render1 = true;
				tempfolders = [SELECT Name FROM EmailTemplate Where FolderId =: foldId];
				System.debug('tempfolders'+tempfolders);
			} else {
				render1 = true;
				tempfolders = [SELECT Name FROM EmailTemplate Where FolderId =: foldId];
				System.debug('tempfolders'+tempfolders+' id '+foldId);
			}
		} catch(Exception e){
		
		}
	}
	
	public List<EmailTemplate> gettempfolders() {
		if(tempfolders.size() != 0) {
			return tempfolders;
		} else {
			return null;
		}
	}
	
	public PageReference onkeyupAction() {
		searchAction();
		return null;
	}
	
	public PageReference searchAction() {
		render1 = true;
		tempfolders = [SELECT Name FROM EmailTemplate Where FolderId =: foldId and Name like : +searchValue+ '%'];
		if(tempfolders.isEmpty()) {
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'No records Found!'));
		}
		return null;
	}
	
}