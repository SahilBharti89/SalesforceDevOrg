public with sharing class EmailTemplateController {
	
	public Boolean render1 {get;set;}
	public List<Folder> folders = new List<Folder>();
	public String searchValue {get; set;}
	
	public EmailTemplateController() {
		try {
			searchValue = ApexPages.currentPage().getParameters().get('parentname');
			String id = ApexPages.currentPage().getParameters().get('parentid');
			if(String.isNotBlank(searchValue)) {
				render1 = true;
				folders = [Select Name From Folder where Name like : +searchValue+ '%' and Type='Email' and DeveloperName != null];
			} else {
				render1 = true;
				folders = [Select Name From Folder where DeveloperName != null ];
			}
		} catch(Exception e){
		
		}
	}
	
	public List<Folder> getfolders() {
		if(folders.size() != 0) {
			return folders;
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
		folders = [Select Name From Folder where Name like : +searchValue+ '%' and Type='Email' and DeveloperName != null];
		if(folders.isEmpty()) {
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'No records Found!'));
		}
		return null;
	}
	/*public EmailTemplateController() {
		folderlist = new list<Folder>([Select id,  Name From Folder where Type='Email']);
		
		if( folderlist != null && !folderlist.isEmpty() ){
			folderName = folderlist[0].Name;
		}
	} */
	
    
}