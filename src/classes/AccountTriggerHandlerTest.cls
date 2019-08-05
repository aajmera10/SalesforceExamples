@isTest
private class AccountTriggerHandlerTest {
    @TestSetup
    static void testSetup(){
        Account accObj = new Account();
        accObj.name = 'Test Name';
        accObj.Account_Type__c = 'Marketing';
        accObj.Country__c = 'France';
        accObj.BillingStreet = 'test add';
        accObj.BillingCity = 'testCIty';
        accObj.BillingState = 'NZ';
        accObj.BillingPostalCode = '302020';
        insert accObj;
        
        Contact conObj = new Contact();
        conObj.AccountId = accObj.id;
        conOBj.LastName = 'Haller';
        insert conObj;
    }
    @isTest
    static void testSimilarTest(){
        Account accObj = [SELECT Id,Name,Account_Type__c,Country__c,BillingStreet,
                                                   BillingCity,BillingState,BillingPostalCode 
                                                   FROM Account 
                                                   WHERE Name = 'Test Name' 
                                                   LIMIT 1];
        
        accObj.BillingStreet ='hvfuinj';
        accObj.BillingCity = 'fvgvte';
        accObj.BillingPostalCode = '12346';
        accObj.BillingState = 'AS';
        update accObj;
        
        List<Account> accList = new List<Account>([SELECT Id,Name,Account_Type__c,Country__c,BillingStreet,
                                                   BillingCity,BillingState,BillingPostalCode 
                                                   FROM Account 
                                                   WHERE Name = 'Test Name' 
                                                   LIMIT 1]);
        AccountTriggerHandler.testSimilar(accList);
        AccountTriggerHandler.accountshouldnotdelete(accList);
        Map<Id,Account> oldMap= new Map<Id,Account>();
        Map<Id,Account> newMap= new Map<Id,Account>();
        oldMap.put(accObj.id, accObj);
        AccountTriggerHandler.accountOutofPostalCode(accList, oldMap, newMap);
    }
}