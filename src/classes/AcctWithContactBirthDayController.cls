public with sharing class AcctWithContactBirthDayController {
    
    public String AccountId = '';
    public List<wrapContact> wrapConList {get;set;}
    public list<integer> monthsList {get;set;}
    public AcctWithContactBirthDayController(ApexPages.StandardController ctrl) { 
        String ActId = (String)ctrl.getId();
        monthsList = new list<integer>{1,2,3,4,5,6,7,8,9,10,11,12};
        //monthsList.addALL();
        wrapConList = new List<wrapContact>();
        for(Contact cont : [Select Id,LastName,BirthDate From Contact where BirthDate != null and 
                            AccountId =:ActId ]){
                                Map<Integer, string> monthsMap = new Map<Integer, string>();
                                //monthsMap = getMonthName();
                                if( cont.BirthDate != null){
                                    
                                    monthsMap.put( cont.BirthDate.month(),string.valueOf(cont.BirthDate));
                                }                   
                                wrapConList.add( new wrapContact(cont.LastName,monthsMap) );
                                System.debug('wrapConList'+wrapConList);
                                System.debug('monthsMap vbvb: '+monthsMap);
                            }
    }
    
    public static Map<Integer,Date> getMonthName() {
        Map<Integer, Date> monthsMap = new Map<Integer, Date>();
        
        monthsMap.put(1,date.today());
        monthsMap.put(2,null);
        monthsMap.put(3,null);
        monthsMap.put(4,null);
        monthsMap.put(5,null);
        monthsMap.put(6,null);
        monthsMap.put(7,null);
        monthsMap.put(8,null);
        monthsMap.put(9,null);
        monthsMap.put(10,null);
        monthsMap.put(11,null);
        monthsMap.put(12,null);
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
        public Map<Integer, string> BirthMonthsMap {get; set;}
        
        public wrapContact(String lName,Map<Integer, string> BirthMonthsMap) {
            
            this.lName = lName;
            this.BirthMonthsMap = BirthMonthsMap;
        }
    }
}