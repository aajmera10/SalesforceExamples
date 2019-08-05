public class ContactTriggerHandler {
    public static void checkDuplicateContact(List<Contact> newList){
        set<Id> accountId = new Set<Id>();
        for(Contact con : newList){
            accountId.add(con.AccountId);      
        }
        Map<Id, Contact> newMap = new Map<Id,Contact>([SELECT id,LastName,Master__c,AccountId
                                                       FROM Contact 
                                                       WHERE Master__c=true 
                                                       AND AccountId IN:accountId]);
        if(newMap.size()>0){
            for(Contact cont:newList){
                if(newMap.containsKey(cont.id)!=null && cont.Master__c==true){
                    cont.addError('Duplicate Deceted');  
                }
            }
            
        }
    }
    
    public static void moreThanOneContact(List<Contact> conList){
        set<Id> accIdSet = new Set<Id>();
        for(Contact con : conList){
            accIdSet.add(con.AccountId);   
        }
        List<Account> updatedAccounts = new List<Account>();
        for(AggregateResult ar : [select count(id) , AccountId FROM Contact WHERE AccountId IN :accIdSet GROUP BY AccountId having count(id)  >1 ]){
            updatedAccounts.add(new Account(Id = (Id)ar.get('AccountId'), Only_Default_Contact__c=false,Account_Type__c = 'Infrastructure'));   
        }
        if(!updatedAccounts.isEmpty())
            update updatedAccounts;
        /* Map<Id, Contact> accts = new Map<Id, Contact>([Select Id, AccountId FROM Contact WHERE AccountId IN :accIdSet]);
List<Account> accntList = new List<Account>();
for(Contact conObj : conList)
{
accntList.add(new Account(Id = accts.get(conObj.AccountId), Only_Default_Contact__c=false)); 
}*/
    }
    
    public static void totalSalaryTrigger(List<Contact> conList){
        Set<String> accIdSet = new Set<String>();
        for(Contact con : conList){
            accIdSet.add(con.AccountId);
        }
        Contact con = conList[0];
        
        AggregateResult[] groupedResults = [SELECT COUNT(Id),SUM(Salary__c)sal, AccountID FROM Contact 
                                            WHERE AccountID IN :accIdSet 
                                            GROUP BY AccountID];
        
        Double d=(Double)groupedResults[0].get('sal');
        
        Account acc  = [SELECT Id,Total_Salary__c FROM Account WHERE Id =: con.AccountId];
        if(acc!=null){
            acc.Total_Salary__c = d;
            update acc;
        }
    }
    public static void websiteTrigger(List<Contact> conList){
        Set<String> existingEmail = new Set<String>();
        for(Contact cont:[SELECT Id,Email FROM Contact]){
            existingEmail.add(cont.Email);
        }
        for(Contact conObj:conList){
            if(existingEmail.contains(conObj.Email)){
                conObj.isDuplicate__c = True;
            }else{
                conObj.isDuplicate__c = False;
            }
        }
    }
    
    public static void contactAccountIsActive (List<Contact>conList){
        Set<String> activeAcc = new Set<String>();
        for(Contact con:conList){
            activeAcc.add(con.AccountId);
        }
        System.debug('activeAcc'+activeAcc);
        Map<Id, Contact> newMap = new Map<Id,Contact>([SELECT id,LastName,isActive__c,AccountId,Account.isActive__c
                                                       FROM Contact 
                                                       WHERE Account.isActive__c=true 
                                                       AND AccountId IN:activeAcc]);
        System.debug('newMap'+newMap);
        if(newMap.size()>0){
            for(Contact cont:conList){
                if(newMap.containsKey(cont.id)!=null){
                    cont.isActive__c = true;
                }
            }
        }
        
    }
    /*public static void closedDate(List<Contact> contacts,Map<Id,Contact>OldMap){
        if(OldMap == null){
            if(contacts.size()>0){
                for(Contact con:contacts){
                    if(con.status__c == 'Closed'){
                        con.Closed_Date__c = System.today();
                    }else{
                        con.Closed_Date__c = null;
                    }
                }
            }
        }
        if(OldMap != null){
            for(Contact con:contacts){
                if(con.status__c != OldMap.get(con.id).status__c){
                    if(con.status__c == 'Closed'){
                        System.debug('IF');
                        con.Closed_Date__c = System.today();
                    }else{
                        System.debug('ELSE');
                        con.Closed_Date__c = null;
                    }
                }
            }
        }
    }*/
    
        public static void onBeforeInsert(List<Contact> contacts){
        if(contacts.size()>0){
            for(Contact con:contacts){
                closedDate(con);
            }            
        }
    }
    
    public static void onBeforeUpdate(List<Contact> contacts,Map<Id,Contact>OldMap){
        if(OldMap != null){
            for(Contact con:contacts){
                if(con.status__c != OldMap.get(con.id).status__c){
                    closedDate(con);
                }
            }
        }
    }
    public static void closedDate(Contact con){
        
        if(con.status__c == 'Closed'){
            con.Closed_Date__c = System.today();
        }else{
            con.Closed_Date__c = null;
        }
    }
}