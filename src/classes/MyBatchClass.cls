global class MyBatchClass implements 
    Database.Batchable<sObject>, Database.Stateful {
        
        global Integer recordsProcessed = 0;
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT ID, BillingStreet, BillingCity, BillingState, ' +
            'BillingPostalCode, (SELECT ID, MailingStreet, MailingCity, ' +
            'MailingState, MailingPostalCode FROM Contacts) FROM Account ' + 
            'Where BillingCountry = \'USA\''
        );
    }
        global void execute(Database.BatchableContext bc, List<Account> scope) {
            List<Contact> contacts = new List<Contact>();
            for (Account acc : scope) {
                for (Contact con : acc.contacts) {
                    con.MailingStreet = acc.BillingStreet;
                    con.MailingCity = acc.BillingCity;
                    con.MailingState = acc.BillingState;
                    con.MailingPostalCode = acc.BillingPostalCode;
                    contacts.add(con);
                    recordsProcessed = recordsProcessed + 1;
                    System.debug('Contact Updated : '+con);
                }
            }
            update contacts;
        }
        
        global void finish(Database.BatchableContext bc) {
            System.debug(recordsProcessed+'record is processed');
            AsyncApexJob job = [Select Id, Status, NumberOfErrors,
               JobItemsProcessed, TotalJobItems, CreatedBy.Email
               From AsyncApexJob
               where Id =: bc.getJobId()];
            //EmailUtils.sendMessage(a, recordsProcessed);
        }

}