@isTest
public class DuplicateConatctTriggerTest {
    @isTest
    public static void crystalmeth(){
        try{
            Contact con = new Contact();
        con.FirstName = 'Vedant';
        con.LastName = 'Pandya';
        con.Email = 'aajmera@hotmail.com';
        insert con;
       // Contact contwo = new Contact();
        Contact contwo = new Contact();
        contwo.FirstName = 'Vedant';
        contwo.LastName = 'Pandya';
        contwo.Email = 'aajmera@hotmail.com';
        insert contwo;
        Contact conthree = new Contact();
        conthree.FirstName = 'Vedant';
        conthree.LastName = 'Pandya';
        conthree.Email = 'aajera@hotmail.com';
        insert conthree;
        Contact confour = new Contact();
        confour.FirstName = 'Veda';
        confour.LastName = 'Pandya';
        confour.Email = 'aajera@hotmail.com';
        insert confour;
        Contact confive = new Contact();
        confive.FirstName = 'Vedant';
        confive.LastName = 'Pdya';
        confive.Email = 'aajera@hotmail.com';
        insert confive;
        }catch(Exception e) {
            System.assert(e.getMessage().contains('You are inserting Duplicate Contact'));
        }
    }
    
}