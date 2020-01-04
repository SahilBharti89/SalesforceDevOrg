public class ContactsListController {
    private String sortOrder = 'LastName';
    public List<Contact> getContacts() {
        List<Contact> result = Database.query('Select Id,FirstName,LastName,Title,Email'+
                                              ' From Contact Order By '+sortOrder+' ASC Limit 10');
        return result;
    }
    
    public void sortByLastName() {
        this.sortOrder = 'LastName';
    }
    
    public void sortByFirstName() {
        this.sortOrder = 'FirstName';
    }
    
}