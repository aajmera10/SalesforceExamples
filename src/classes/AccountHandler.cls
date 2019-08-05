public class AccountHandler {
    public static Account insertNewAccount (String n){
         Account acc = new Account();
        acc.Name = n;
        try{
           
            insert acc;
        }catch(System.DmlException e){
            return null;
            
        }
        return acc;
    }
}