public class UpdateParentAccount implements Queueable {
    private List<Account> accList;
    private ID parent;
    
    public UpdateParentAccount(List<Account> records, ID id) {
        this.accList = records;
        this.parent = id;
    }
    
    public void execute(QueueableContext qc) {
        for(Account acc : accList) {
            acc.parentId = parent;
            System.debug('Affected Account : '+acc);
        }
        update accList;
    }

}