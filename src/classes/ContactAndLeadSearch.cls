public class ContactAndLeadSearch {
    public static List<List<sObject>> searchContactsAndLeads(String n){
        List<List<sObject>> searchList = [FIND 'Smith' IN ALL FIELDS 
                   RETURNING Lead(FirstName,LastName),Contact(FirstName,LastName,Department)];
    
    
    return searchList;
    }
}