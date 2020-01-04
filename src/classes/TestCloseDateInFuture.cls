@isTest
public with sharing class TestCloseDateInFuture {
	
	 static testmethod void TestCloseDate() {
	 	Opportunity opp = new Opportunity();
	 	opp.Name='Test Opp';
	 	opp.CloseDate=System.today().addDays(-1);
	 	opp.StageName='Prospecting';
	 	
	 	Test.startTest();
	 	//insert opp;
	 	Test.stopTest();
	 	try{
	 		insert opp;
	 	} catch(Exception e) {
	 		Boolean expectedExceptionThrown =  e.getMessage().contains('Close Date must be in Future.') ? true : false;
			System.assertEquals(expectedExceptionThrown, true);
	 	}

	 }
    
}