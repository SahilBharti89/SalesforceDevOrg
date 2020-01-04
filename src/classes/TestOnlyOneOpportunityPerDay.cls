@isTest
public with sharing class TestOnlyOneOpportunityPerDay {
	
	static testmethod void TestOnlyOneOpportunity() {
		Account acc = new Account();
		acc.Name = 'Test t1';
		insert acc;
		
		Opportunity opp = new Opportunity();
	 	opp.Name='Test Opp';
	 	opp.CloseDate=System.today().addDays(2);
	 	opp.StageName='Prospecting';
	 	opp.AccountId = acc.Id;
	 	insert opp;
	 	
	 	Opportunity opp1 = new Opportunity();
	 	opp1.Name='Test Opp';
	 	opp1.CloseDate=System.today().addDays(2);
	 	opp1.StageName='Prospecting';
	 	opp1.AccountId = acc.Id;
	 	

	 	try {
	 		insert opp1;
	 	}catch(Exception e) {
	 		//Boolean expectedExceptionThrown =  e.getMessage().contains('You can not create more than one Opportunity in Same Day.') ? true : false;
			//System.assertEquals(expectedExceptionThrown, false);
	 	}
	}
    
}