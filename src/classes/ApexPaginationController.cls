
public class ApexPaginationController {
    private User loggedInUser;
    private string givenAccountId;
    Public Id AccountId;
    private string defaultFilterCriteria;
    private string filterCriteria;  
    public string searchStatusVal { get; set; }
    public String searchUserRewardsVal {get;set;}
    public String searchAssignRewardsVal {get;set;}
    public string searchLastNameVal { get; set; }
    public string searchJobTitleVal { get; set; }
    public string searchFirstNameVal { get; set; }
    public Integer pageSize { get; set; }
    public Integer totalPageNumber { get; set; }  
    public boolean isPartnerAdmin { get; private set; }
    public boolean isPermittedUser { get; private set; }
    public boolean hasError { get{ return (PageUtils.getErrorMessagesOnly().size() > 0); } }
    public List<contactWrapper> users { get; private set; }
    Public boolean temp{get;set;}   
    public final Integer DEFAULT_PAGE_SIZE = 3;
    public final string prChangeDescription = 'Bulk Nomination Changes: Incentives Portal = ';
    public string myRewardsValue {get;set;}
    public string rewardsRole {get;set;}
   
    Map<Id, contactWrapper> mapHoldingSelectedRecords{get;set;}
    

    
    
    public ApexPaginationController(){
        try{
            isPartnerAdmin = false;
            isPermittedUser = false;
            searchStatusVal = Label.Bulk_Nomination_All;
            pageSize = 3;
            mapHoldingSelectedRecords = new Map<Id, contactWrapper>();
            //init();
            
             
            loggedInUser = [SELECT Enable_Partner_Admin__c, UserType , Contact.AccountId, Contact.Account.Id, Contact.Title FROM User WHERE Id = :UserInfo.getUserId()];
            system.debug('user type-----------------------'+loggedInUser.Usertype);
            if((loggedInUser.Contact != null) && (loggedInUser.Contact.Account != null)) { 
            
                givenAccountId = loggedInUser.Contact.AccountId;
                system.Debug('the account id Account ID' +givenAccountId);
                
                
            }
            if(givenAccountId == null || givenAccountId.length() == 0){
                givenAccountId = PageUtils.get('accountId'); // 001Z000000FgTv5
                system.Debug('the account id Account ID' +givenAccountId);
                
            }
        }catch(Exception ex){
            system.debug('');
            PageUtils.addError('');
        }
        

    }
    
    public void init() {
 users  = new List<contactWrapper>();
 for (user cont: (List<user>)getUserStdSetController.getRecords()) {
 if(mapHoldingSelectedRecords != null && mapHoldingSelectedRecords.containsKey(cont.id)){
 users.add(mapHoldingSelectedRecords.get(cont.id));
 
 }
 
 }
 }
 
 
    
    public PageReference doPageLoad(){
        try{
            if(givenAccountId == null || givenAccountId.length() == 0){ 
                PageUtils.addError('Invalid account Id.'); 
            }else{ 
                myRewardsValue = [Select Id, MyRewards_Enabled__c from Account Where Id =: givenAccountId].MyRewards_Enabled__c;
                
                if((loggedInUser.Contact != null) && (loggedInUser.Contact.Account != null)){
                    isPartnerAdmin = loggedInUser.Enable_Partner_Admin__c;
                }else{
                    Set<Id> permittedProfileIds = new Set<Id>();
                    permittedProfileIds.add('00e30000000nJ6K');
                    permittedProfileIds.add('00e70000000wzqq'); 
                    permittedProfileIds.add('00e70000000x0Xj'); 
                    permittedProfileIds.add('00eA0000000hOpn'); 
                    permittedProfileIds.add('00eA0000000hOps');
                    permittedProfileIds.add('00eA0000000hORl');
                    permittedProfileIds.add('00eA0000000hORq'); 
                    
                    isPermittedUser = permittedProfileIds.contains(UserInfo.getProfileId());
                }
                  system.debug('permitted user and partneradmin-----------------------------'+isPermittedUser  + isPartnerAdmin);
                if(!isPermittedUser && !isPartnerAdmin){                
                    PageUtils.addError(Label.access_denied); 
                }else{
                    defaultFilterCriteria = 'WHERE Contact.AccountId = \'' + givenAccountId + '\' AND IsActive = TRUE';
                    filterCriteria = defaultFilterCriteria;
                    
                    populateContactWrapper((List<User>)getUserStdSetController.getRecords());
                }
            } 
        }catch(Exception ex){
            system.debug('');
            PageUtils.addError('');
        }
        return null;
    }
    

    private ApexPages.StandardSetController getUserStdSetController {
        get{
            try{
                if(getUserStdSetController  == null){    
                    string queryString = 'SELECT Enable_Partner_Admin__c, Enable_As_Partner_Lead_Super_User__c, Contact.Email_Opt_In__c, Contact.Title, ' + 
                                            'Name, Contact.Email, Contact.MobilePhone, Contact.Fax, Contact.Phone, Contact.MailingCountry, ' +
                                            'Contact.MailingPostalCode, Contact.MailingState, Contact.MailingCity, Contact.MailingStreet, ' +
                                            'Contact.Salutation, Contact.FirstName, Contact.LastName, ContactId, Contact.AccountId, Contact.Account.id, ' +
                                            'Contact.Account.name, Contact.Account.account_country_code__c, userrole.name, ' +
                                            'Contact.Account.ShippingStreet,Contact.Account.ShippingCity,Enable_Partner_Deal_Registration__c, Enable_Partner_Lead_Management__c,' +
                                            'Contact.Account.ShippingState,Contact.Account.ShippingPostalCode,FirstName,LastName, Contact.Is_Enabled_for_Incentives__c, ' +
                                            'Contact.Account.Phone,Contact.Account.Fax,Contact.Account.Is_Rebate_Partner__c, Contact.Is_Rebate_User__c,Contact.Assign_MyRewards_Role__c,Contact.Enable_User_for_MyRewards__c ' +
                                            'FROM User ' + filterCriteria + ' ORDER BY Name LIMIT 10000';
                                            
                                            
                    getUserStdSetController = new ApexPages.StandardSetController(Database.getQueryLocator(queryString));
                    
                    system.Debug('Account' +getUserStdSetController);
                    
                    getUserStdSetController.setPageSize(DEFAULT_PAGE_SIZE);
                    totalPageNumber = Integer.valueOf(Math.ceil((Double)getUserStdSetController.getResultSize()/pageSize));
                }
            }catch(Exception ex){
                throw ex;
            }
            return getUserStdSetController;
        }set;
    }
    
    
    public Boolean hasNext {
 get {
   return getUserStdSetController.getHasNext();
 }
 set;
 }
 
 
 public Boolean hasPrevious {
 get {
   return getUserStdSetController.getHasPrevious();
 }
 set;
 }
 
 
 public Integer pageNumber {
 get {
   return getUserStdSetController.getPageNumber();
 }
 set;
 }
 
 
 
 Public Integer getTotalPages(){
     Decimal totalSize = getUserStdSetController.getResultSize();
     Decimal pageSize = getUserStdSetController.getPageSize();
     Decimal pages = totalSize/pageSize;
     return (Integer)pages.round(System.RoundingMode.CEILING);
 }
 
 
 
  public void first() {
   updateSearchItemsMap();
   getUserStdSetController.first();
   init();
 }
 

 public void last() {
   updateSearchItemsMap();
   getUserStdSetController.last();
   init();
 }
 

 public void previous() {
   updateSearchItemsMap();
   getUserStdSetController.previous();
   init();
 }
 
 
 public void next() {
 
 updateSearchItemsMap();
   getUserStdSetController.next();
   init();
 
 }
 
 
 private void updateSearchItemsMap() {
 for(contactWrapper wrp : users){
  if(wrp.enableUserForMyRewardsInput){
     mapHoldingSelectedRecords.put(wrp.userId, wrp);
  }
  if(wrp.enableUserForMyRewardsInput == false && mapHoldingSelectedRecords.containsKey(wrp.userId)){
     mapHoldingSelectedRecords.remove(wrp.userId);
  }
 }
 }
 
   private void populateContactWrapper(List<User> uList){
        try{
            if(users == null){
                users = new List<contactWrapper>();
            }else{
                users.clear();
            }
            
            for(User u : uList){ 
                users.add(new contactWrapper(u)); 
            }
        }catch(Exception ex){
            throw ex;
        }
    }
    
    private Id getRecordTypeId(String recordTypeName){
        Id recordTypeId = IdLookupUtils.getRecordTypeId(recordTypeName, 'Partner_Request__c', true);
        System.assert(recordTypeId != null,'Record type \'' + recordTypeName + '\' not found.');
        return recordTypeId;
    }
    
    
    public void next() {
        try{
            getUserStdSetController.next();
            populateContactWrapper((List<User>)getUserStdSetController.getRecords());
            updateSearchItemsMap();
            init();
            
        }catch(Exception ex){
            system.debug('');
            PageUtils.addError('');
        }
    }
     
    public void previous() {
        try{
            getUserStdSetController.previous();
            populateContactWrapper((List<User>)getUserStdSetController.getRecords());
            updateSearchItemsMap();
            init();
            
        }catch(Exception ex){
            system.debug('');
            PageUtils.addError('');
        }
    }
      
     public void first() {
        try{
            getUserStdSetController.first();
            populateContactWrapper((List<User>)getUserStdSetController.getRecords());
            updateSearchItemsMap();
            init();
        }catch(Exception ex){
            system.debug('');
            PageUtils.addError('');
        }
    }
 
    public void last() {
        try{
            getUserStdSetController.last();
            populateContactWrapper((List<User>)getUserStdSetController.getRecords());
            updateSearchItemsMap();
            init();
        }catch(Exception ex){
            system.debug('');
            PageUtils.addError('');
        }
    } 
    
    public Boolean hasNext {
        get {
            try{
                hasNext =  getUserStdSetController.getHasNext();
                updateSearchItemsMap();
                init();
            }catch(Exception ex){
                system.debug('');
                PageUtils.addError('');
            }
            return hasNext;
        }
        set;
    }
    
    public Boolean hasPrevious {
        get {
            try{
                hasPrevious = getUserStdSetController.getHasPrevious();
                updateSearchItemsMap();
                init();
            }catch(Exception ex){
                system.debug('');
                PageUtils.addError('');
            }
            return hasPrevious;
        }
        set;
    }
 
    public Integer pageNumber1 {
        get {
            try{
                pageNumber = getUserStdSetController.getPageNumber();
            }catch(Exception ex){
                system.debug('');
                PageUtils.addError('');
            }
            return pageNumber;
        }
        set;
    } 
    
    public pagereference backreference(){
        AccountId = PageUtils.get('accountId');
        Pagereference pageref = new pagereference('/' +AccountId);
        return pageref;
        
    }
    
    public class contactWrapper{
        public Id userId { get; set; }
        public Id contactId { get; set; }
        public string Name { get; set; }
        public string Title { get; set; }
        public string isAdmin { get; set; }
        public boolean enabledIncentive { get; set; }
        public boolean enabledIncentiveInput { get; set; }
        public User portalUser { get; set; }
        public string rewardsRole { get;set; }
        public string rewardsRoleInput { get;set; }
        public boolean enableUserForMyRewards{ get;set; }
        public boolean enableUserForMyRewardsInput{ get;set; }
        

        public contactWrapper(User u){
            this.userId = u.Id;
            this.contactId = u.Contact.Id;
            this.Name = u.Name;
            this.Title = u.Contact.Title;
            this.isAdmin = u.Enable_Partner_Admin__c ? Label.yes : Label.no;
            this.enabledIncentive = u.Contact.Is_Enabled_for_Incentives__c;
            this.enabledIncentiveInput = u.Contact.Is_Enabled_for_Incentives__c;
            this.enableUserForMyRewards = u.Contact.Enable_User_for_MyRewards__c;
            this.enableUserForMyRewardsInput = u.Contact.Enable_User_for_MyRewards__c;
            this.rewardsRole = u.Contact.Assign_MyRewards_Role__c;
            this.rewardsRoleInput = u.Contact.Assign_MyRewards_Role__c;
            this.portalUser = u;
            
        }
    }
    
    
           
   
   
    public void saveAction(){
        try{
            contact blankCon = new contact();
            list<contact> conToUpdate = new list<contact>();
            for(contactWrapper w : users){
                contact con = new contact();
                if(w.rewardsRoleInput != w.rewardsRole){
                    con.id = w.contactId;
                    con.Assign_MyRewards_Role__c = w.rewardsRoleInput;                   
                }
                if(w.enableUserForMyRewards != w.enableUserForMyRewardsInput){
                     con.id = w.contactId;
                     con.Enable_User_for_MyRewards__c = w.enableUserForMyRewardsInput;
                }
                
               if(w.enabledIncentive != w.enabledIncentiveInput){
                     con.id = w.contactId;
                     con.Is_Enabled_for_Incentives__c = w.enabledIncentiveInput;
                }
                                
                if(con != blankCon){
                    conToUpdate.add(con);
                }
            }          
            
            update conToUpdate;
            integer currentPageNumber = pageNumber;
            getUserStdSetController = null;
            getUserStdSetController.setPageNumber(currentPageNumber);
            populateContactWrapper((List<User>)getUserStdSetController.getRecords()); 
        }catch(Exception ex){
            system.debug('');
            PageUtils.addError('');
        }
        
    }

}