public with sharing class DynamicBindingFieldsOnVFPage {
    public DynamicBindingFieldsOnVFPage(ApexPages.StandardController controller) {
    }
    public pagereference dosave()
    {
        return null;
    }
    public List<String> lstfields = new List<String>();
    public List<String> getfields(){
        lstfields.add('Email');
        lstfields.add('FirstName');
        lstfields.add('LastName');
        return lstfields;
    }
}