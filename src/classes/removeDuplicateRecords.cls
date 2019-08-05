global class removeDuplicateRecords implements Database.Batchable<SObject> , Database.Stateful{
    
    global Map<String , Account> accountMap = new Map<String , Account>();
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator([SELECT Id, Name, Country__c,Account_Type__c FROM Account WHERE Name!=null AND Country__c!=null
                                         AND Account_Type__c!=null]);
    }
    
    global void execute(Database.BatchableContext BC , List<Account> scope){
        
        List<Account> duplicatelist = new List<Account>();
        Set<String> uniqueSet = new Set<String>();
        String uniqueIdKey;
        
        for(Account acct:scope){
            uniqueIdKey = acct.Name+acct.Account_Type__c+acct.Country__c;
            if(!uniqueSet.contains(uniqueIdKey)){
              uniqueSet.add(uniqueIdKey);
            }else{
                 duplicatelist.add(acct);
            }
        }
        System.debug(duplicatelist);
        System.debug('>>>>>>>>>>>>>>>>>>>>>>>>>'+duplicatelist.size());
        delete duplicatelist;
    }
    
    global void finish(Database.BatchableContext BC){
    }
    
    
}


 /*if(!AccountMap.containsKey(s.name) && !AccountMap.containsKey(s.Account_Type__c) && !AccountMap.containsKey(s.country__c)){
AccountMap.put(s.name , s);
AccountMap.put(s.Account_Type__c , s);
AccountMap.put(s.country__c , s);
}  else{
duplicatelist.add(s);          
}*/ /////////////////////////////////////////////////////////////


 /* Set<String> nameSet = new Set<String>();
        Set<String> typeSet = new Set<String>();
        Set<String> countrySet = new Set<String>();
        Set<String> idSet =  new Set<String>();
        List<String> duplicatelist = new List<String>();
        for(Account acc : scope){
           
            duplicatelist.add(acc.name);
            duplicatelist.add(acc.Account_Type__c);
            duplicatelist.add(acc.Country__c);
        } 

        List <Account> entr = new List<Account>([SELECT id,Name,Account_Type__c,Country__c FROM Account WHERE Name IN:duplicatelist AND
                                                 Account_Type__c IN:duplicatelist AND Country__c IN:duplicatelist]);
        
        List<Account> accountsToDelete = new List<Account>();
       
        string accName = 'placeholder12345';
        string accTypeName = 'placeholder12345';
        string accCountryName = 'placeholder12345';
        
        system.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>'+duplicatelist);
        system.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>'+duplicatelist.size());
        for(Account acct: entr){
           
            if(acct.Account_Type__c == accTypeName && acct.Country__c == accCountryName && acct.Name==accName){
                accountsToDelete.add(acct);
            }
            accTypeName =acct.Account_Type__c;
            accCountryName = acct.Country__c;
            accName = acct.Name;
           
        }
        system.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>'+accountsToDelete);
          system.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>'+accountsToDelete.size());
        if(!accountsToDelete.isEmpty())
        {
            //delete those suckers.
            delete accountsToDelete;
        }
        system.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>'+duplicatelist);
        system.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>'+duplicatelist.size());*/
        

////////////////////////////////////////////////////////////////

//////
// if(!accountMap.containsKey(acc.country__c) && accountMap.containsKey(acc.Account_Type__c) && accountMap.containsKey(acc.name)){
//                accountMap.put(acc.country__c , acc);
//                accountMap.put(acc.Account_Type__c , acc);
//                accountMap.put(acc.name , acc);
//                
//            }
 //           else{
 //               duplicatelist.add(acc);
//            }

 // String uniqueId = acct.name+acct.Account_Type__c+acct.Country__c;
            // if(idSet.contains(uniqueId)){
            //acct.adderror('Duplicates Detected');
            // }
            //system.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>'+duplicatelist);
            //   system.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>'+duplicatelist.size());
            //if(duplicatelist.size() > 0){
            // delete duplicatelist;