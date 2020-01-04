/*public class ContactAndLeadSearch {
    public static List<List<SObject>> searchContactsAndLeads(String lastname)
    {
        List<List< SObject>> searchResult = [FIND 'Smith' in ALL FIELDS 
                                            RETURNING Contact(Name), Lead(LastName) ];
        Contact[] searchContacts =(Contact[])searchResult[0];
        Lead[] searchLeads =(Lead[])searchResult[1];
        System.debug('Found the following Contacts.');
		for (Contact c : searchContacts) {
    		System.debug(c.Name);
		}
		System.debug('Found the following Leads.');
		for (Lead l : searchLeads) {
    	System.debug(l.LastName);
		}
        return searchResult;
    }

}*/
public class ContactAndLeadSearch
{
    public static List<List<SObject>> searchContactsAndLeads(String str)
    {
        List<List<sObject>> searchList = [FIND :str IN ALL FIELDS RETURNING Contact(FirstName,LastName) ,Lead(FirstName,Lastname)];
        return searchList;
    }
}