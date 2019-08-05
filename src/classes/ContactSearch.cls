public class ContactSearch {
    public static List<Contact> searchForContacts(String n ,String j){
      
        List<Contact> con=[SELECT id,FirstName,LastName FROM Contact WHERE LastName=:n AND MailingPostalCode=:j];
        return con;
    } 

}