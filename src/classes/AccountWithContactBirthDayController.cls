public with sharing class AccountWithContactBirthDayController {
    
    public String AccountId = '';
    public List<wrapContact> wrapConList {get;set;}
    
    public AccountWithContactBirthDayController(ApexPages.StandardController ctrl) { 
        String ActId = (String)ctrl.getId();
        wrapConList = new List<wrapContact>();
        for(Contact cont : [Select Id,LastName,BirthDate From Contact where BirthDate != null and 
                            AccountId =:ActId ]){
                                Map<Integer, Boolean> monthsMap = new Map<Integer, Boolean>();
                                monthsMap = getMonthName();
                                if( cont.BirthDate != null && monthsMap.containsKey(cont.BirthDate.month())){
                                    
                                    monthsMap.put( cont.BirthDate.month(),true);
                                }	                
                                wrapConList.add( new wrapContact(cont.LastName,monthsMap) );
                                System.debug('wrapConList'+wrapConList);
                                System.debug('monthsMap : '+monthsMap);
                            }
    }
    
    public static Map<Integer,Boolean> getMonthName() {
        Map<Integer, Boolean> monthsMap = new Map<Integer, Boolean>();
        
        monthsMap.put(1,false);
        monthsMap.put(2,false);
        monthsMap.put(3,false);
        monthsMap.put(4,false);
        monthsMap.put(5,false);
        monthsMap.put(6,false);
        monthsMap.put(7,false);
        monthsMap.put(8,false);
        monthsMap.put(9,false);
        monthsMap.put(10,false);
        monthsMap.put(11,false);
        monthsMap.put(12,false);
        return monthsMap;
    }
    
    public Map<Integer,String> getMonthName1() {
        Map<Integer, String> monthsMap = new Map<Integer, String>();
        monthsMap.put(1, 'January');
        monthsMap.put(2, 'February');
        monthsMap.put(3, 'March');
        monthsMap.put(4, 'April');
        monthsMap.put(5, 'May');
        monthsMap.put(6, 'June');
        monthsMap.put(7, 'July');
        monthsMap.put(8, 'August');
        monthsMap.put(9, 'September');
        monthsMap.put(10, 'October');
        monthsMap.put(11, 'November');
        monthsMap.put(12, 'December');
        return monthsMap;
    }
    
    public class wrapContact {
        public String lName {get; set;}
        public Map<Integer, Boolean> BirthMonthsMap {get; set;}
        
        public wrapContact(String lName,Map<Integer, Boolean> BirthMonthsMap) {
            
            this.lName = lName;
            this.BirthMonthsMap = BirthMonthsMap;
        }
    }
}