@RestResource(urlMapping='/Cases/*')
global with sharing class CaseManager {
	
    @HttpGet
    global static Case getCaseById() {
        RestRequest request = RestContext.request;
        String caseId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        Case result = [Select CaseNumber,Subject,Status,Origin,Priority From Case
                      where Id =: caseId];
        return result;
    }
    
    @HttpPost
    global static ID createCase(String subject,String status,String origin, String priority) {
        Case thisCase = new Case();
        thisCase.Subject = subject;
        thisCase.Status = status;
        thisCase.Origin = origin;
        thisCase.Priority = priority;
        insert thisCase;
        
        return thisCase.Id;
    }
    
    @HttpDelete
    global static void deleteCase() {
        RestRequest request = RestContext.request;
        String caseId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        Case thisCase = [Select Id From Case where Id =: caseId];
        delete thisCase;
    }
    
    @HttpPut
    global static ID upsertCase(String subject,String status,String origin, String priority,String id) {
        Case thisCase = new Case();
        thisCase.Id = id;
        thisCase.Subject = subject;
        thisCase.Status = status;
        thisCase.Origin = origin;
        thisCase.Priority = priority;
        upsert thisCase;
        
        return thisCase.Id;
    }
    
    @HttpPatch
    global static ID updateCaseFields() {
        RestRequest request = RestContext.request;
        String caseId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        Case thisCase = [Select Id From Case where Id =: caseId];
        Map<String,Object> params = (Map<String,Object>) JSON.deserializeUntyped(request.requestbody.toString());
        for(String fieldName : params.keySet()){
            thisCase.put(fieldName,params.get(fieldName));
        }
        update thisCase;
        return thisCase.Id;
    }
    
    
}