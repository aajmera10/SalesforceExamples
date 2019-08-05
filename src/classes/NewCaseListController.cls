public class NewCaseListController {
    //private String sortOrder = 'New';
    public List<Case> getNewCases(){
        
        List<Case> results = [SELECT Id,CaseNumber FROM case WHERE status='New'];
        return results;
        
    }
}
//List<Contact> results = Database.query(
//          'SELECT Id, FirstName, LastName, Title, Email, Master__c ' +
//          'FROM Contact ' +
//         'ORDER BY ' + sortOrder + ' ASC ' +
//        'LIMIT 10'
//    );
//   return results;