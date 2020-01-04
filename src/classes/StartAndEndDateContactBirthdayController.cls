public with sharing class StartAndEndDateContactBirthdayController {
	public List<wrapAccount> wrapAccList {get;set;}
	public Date startDate {get;set;}
   	public Date endDate {get;set;}
    
    public StartAndEndDateContactBirthdayController() { 
        startDate = Date.Today();
        endDate = Date.Today();
    }
    
    public List<wrapAccount> getwrapAccList() {
    	wrapAccList = new List<wrapAccount>();
        for(Account acc : [Select Id,Name,(Select Id,BirthDate From Contacts where BirthDate != null) From Account Limit 10]){
            Map<Integer, Integer> monthsMap = new Map<Integer, Integer>();
            monthsMap = getMonthName(startDate.month(),endDate.month());
            if( acc.Contacts != null && !acc.Contacts.isEmpty()){
                for(Contact cont : acc.Contacts ){
                    if( monthsMap != null &&  !monthsMap.isEmpty() && monthsMap.containskey( cont.BirthDate.month() ) ){
                        Integer count = monthsMap.get( cont.BirthDate.month() );
                        monthsMap.put( cont.BirthDate.month(),++count);
                    }
                }
            }
            wrapAccList.add( new wrapAccount(acc.Name,acc.Contacts.size(), monthsMap) );
            
        }
        return wrapAccList;
    }
   
    public static Map<Integer,Integer> getMonthName(Integer startDateN0,Integer endDateN0) {
        Map<Integer, Integer> monthsMap = new Map<Integer, Integer>();
       for(Integer i=startDateN0;i<=endDateN0;i++) {
       		monthsMap.put(i,0);
       }
        System.debug('getMonthName Map :'+monthsMap);  
        return monthsMap;
    }
    
    public void onSubmit() {
    	getwrapAccList();
    }
    
    public Map<Integer, String>  getMonthName1() {
        Integer startDateN0 = startDate.month();
        Integer endDateN0 = endDate.month();
       Map<Integer, String> monthsMap1 = new Map<Integer, String>();
       String[] monthsName =new list<String>(); 
       monthsName.add('');
       monthsName.add('January');
       monthsName.add('February');
       monthsName.add('March');
       monthsName.add('April');
       monthsName.add('May');
       monthsName.add('June');
       monthsName.add('July');
       monthsName.add('August');
       monthsName.add('September');
       monthsName.add('October');
       monthsName.add('November');
       monthsName.add('December');
       for(Integer i=startDateN0;i<=endDateN0;i++) {
       		monthsMap1.put(i,monthsName[i]);
       }
       System.debug('getMonthName1 Map1 :'+monthsMap1);     
        return monthsMap1;
    }
    
    public class wrapAccount {
        public String AccountName {get;set;}
        public Integer contactCount {get; set;}
        public Map<Integer,integer> monthVsContacts{get;set;}
        
        public wrapAccount(String AccountName,Integer contactCount,Map<Integer,integer> monthVsContacts) {
            this.AccountName = AccountName;
            this.contactCount = contactCount;
            this.monthVsContacts = monthVsContacts;
        }
    }   
}