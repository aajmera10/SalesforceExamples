public class AccountTriggerHandler {
    public static void testSimilar(List<Account> accList){
        Set<String> stringidSet = new Set<String>();        
        for(Account accn: [SELECT id,Name,Account_Type__c,Country__c FROM Account WHERE Name!=null OR Country__c!=null
                           OR Account_Type__c!=null]){
                               String uniqueId = accn.name+accn.Account_Type__c+accn.Country__c;
                               stringidSet.add(uniqueId);    
                           }
        for(Account acc : accList){
            String uniqueId = acc.name+acc.Account_Type__c+acc.Country__c;
            if(stringidSet.contains(uniqueId)){
                acc.addError('duplicate Account');
            }
        }
   }
    
    public static void accountshouldnotdelete(List<Account> accList){
        Set<id> accIdSet = new Set<id>();  
        for(Account acc : accList){  
            accIdSet.add(acc.id);  
        }  
        
        Map<Id, Account> accts = new Map<Id, Account>([Select Id, (Select Id from contacts) from Account where id in :accIdSet]);
        
        for(Account acc : accList){
            if(accts.get(acc.id).contacts.size()>0){
                acc.adderror('Account cannot be deleted');
            }
        }                   
        
    }
    public static void accountOutofPostalCode(List<Account> accList, Map<ID,Account>OldMap, Map<Id,Account>NewMap){
        Set<Id> accIds = new Set<Id>();
        List<Contact> conList = new List<Contact>();
        for(Account accObjt: accList){        
            if(accObjt.BillingStreet != OldMap.get(accObjt.id).BillingStreet || accObjt.BillingCity!= OldMap.get(accObjt.id).BillingCity || 
               accObjt.BillingState != OldMap.get(accObjt.id).BillingState || accObjt.BillingPostalCode != OldMap.get(accObjt.id).BillingPostalCode){
                   accIds.add(accObjt.Id);
               }
        }
        conList=[Select Id,AccountId,MailingPostalCode from contact where AccountId IN: accIds];
        
        for(Contact con:conList){
            Account accObj = NewMap.get(con.AccountId);
            if(con.MailingPostalCode != accObj.BillingPostalCode){
                accobj.Out_of_Postal__c =TRUE; 
            }else{
                accobj.Out_of_Postal__c =False; 
            }
            
        }
    }
    
    public static void isActiveTrigger(List<Account> accList){
        Set<String> idSet = new Set<String>();
        List<Contact> conList = new List<Contact>();
        List<Contact> conList1 = new List<Contact>();
        for(Account acc:accList){
            idSet.add(acc.id);
        }
        System.debug('idSet'+idSet);
        
        List<Account> acctList = new List<Account>([SELECT id,isActive__c,(Select id,isActive__c,Lastname From Contacts)
                                                    FROM Account WHERE id in: idSet]);
        if(acctList.size()>0){
        for(Account acct : acctList){
            conList.addAll(acct.Contacts);
        }}
        System.debug('acctList'+acctList);
        System.debug('conList'+conList);
        
        for(Contact con: conList){
            con.isActive__c = true;
            conList1.add(con);
        }
        System.debug('conList1'+conList1);
        update conList1;
        /*Map<Id, Contact> newMap = new Map<Id,Contact>([SELECT id,LastName,isActive__c,AccountId,Account.isActive__c
                                                       FROM Contact 
                                                       WHERE Account.isActive__c=true 
                                                       AND AccountId IN:idSet]);
        
        System.debug('newMap'+newMap);
        if(newMap.size()>0){
            for(Account acc:accList){
                if(newMap.containsKey(acc.Id)!=null){
                    //cont.isActive__c = true;
                    System.debug('isActive__c'+newMap.get(acc.Id).isActive__c);
                }
            }
        }*/
    }
    
    public static void onlyDefaultContactTrigger(List<Account>accList){
        Set<Id> accIdSet = new Set<Id>();
        for(Account acc:accList){
            Contact con = new Contact();
            con.FirstName = 'Info';
            con.LastName = 'Default';
            con.AccountId = acc.Id;
            con.Email = 'info@websitedomain.tld';
            insert con;
            accIdSet.add(acc.Id);
        }
        Map<Id, Account> accts = new Map<Id, Account>([Select Id, (Select Id from contacts) from Account where id in :accIdSet]);
        
        for(Account acc : accList)
        {
            if(accts.get(acc.id).contacts.size()>1){
                acc.Only_Default_Contact__c = False;
            }else{
                //acc.Only_Default_Contact__c = TRUE;
            }
        }
    }
    
}