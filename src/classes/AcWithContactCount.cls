public class AcWithContactCount {
    public List<wrapAccount> wrapAccList {get;set;}
    public AcWithContactCount() { 
        wrapAccList = new List<wrapAccount>();
        for(Account acc : [Select Id,Name,(Select Id,BirthDate From Contacts where BirthDate != null) From Account Limit 10]){
            Map<Integer, Integer> monthsMap = new Map<Integer, Integer>();
            monthsMap = getMonthName();
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
    }
    
    public static Map<Integer,Integer> getMonthName() {
        Map<Integer, Integer> monthsMap = new Map<Integer, Integer>();
       
        monthsMap.put(1, 0);
        monthsMap.put(2, 0);
        monthsMap.put(3, 0);
        monthsMap.put(4, 0);
        monthsMap.put(5, 0);
        monthsMap.put(6, 0);
        monthsMap.put(7, 0);
        monthsMap.put(8, 0);
        monthsMap.put(9, 0);
        monthsMap.put(10, 0);
        monthsMap.put(11, 0);
        monthsMap.put(12, 0);
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