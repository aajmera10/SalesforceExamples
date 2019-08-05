@isTest
public class LeadProcessorTest {
@isTest
    public static void leadbatchTest(){
        List<Lead> l = new List<Lead>();
        Lead lead = new Lead();
        lead.LastName='Phatan';
        lead.Company= 'Source Code';
        lead.LeadSource='Dreamforce';
        l.add(lead);
        insert l;
        
    Test.startTest();
    LeadProcessor lp= new LeadProcessor();
    Id jobid= Database.executeBatch(lp);
    Test.stopTest();
    }
    
}