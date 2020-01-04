@IsTest
public class VerifyDateTest {
    public static testmethod void TestVerifyDateTest () {
        Date dt1 = date.newInstance(2018, 07, 24);
        Date dt2 = date.newInstance(2018, 07, 26);
        
        Test.startTest();
        	VerifyDate.CheckDates(dt1,dt2);
        Test.stopTest();
    }
    public static testmethod void TestVerifyDateTest1 () {
        Date dt1 = date.newInstance(2018, 07, 24);
        Date dt2 = date.newInstance(2018, 09, 26);
        
        Test.startTest();
        	VerifyDate.CheckDates(dt1,dt2);
        Test.stopTest();
    }
    
    public static testmethod void TestVerifyDateTest2 () {
        Date dt1 = date.newInstance(2018, 07, 24);
        Date dt2 = date.newInstance(2018, 05, 26);
        
        Test.startTest();
        	VerifyDate.CheckDates(dt1,dt2);
        Test.stopTest();
    }


    
    
    
    

}