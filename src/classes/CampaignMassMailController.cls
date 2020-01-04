public with sharing class CampaignMassMailController {
    public String folderName {get; set;}
    public String folderId {get; set;}
    public String templateName {get;set;}
    public String templateId {get; set;}
    public EmailTemplate emlt {get;set;}
    public Boolean showButton {get; set;}
    
    public CampaignMassMailController(ApexPages.StandardController ctrl){
    	folderName = 'Select Folder';
    	folderId = '';
    	templateName = 'Select Template';
    	templateId='';
    	emlt = new EmailTemplate();
    }
    
    public void onSubmit() {
    	//templateId = ApexPages.currentPage().getParameters().get('tempval');
    	System.debug('templateId'+templateId);
    	emlt = new EmailTemplate();
    	emlt = [SELECT Id,Name,body,Markup,HtmlValue FROM EmailTemplate  Where Id =: templateId];
    	templateName = emlt.Name;
    	//return null;
    }
    
}