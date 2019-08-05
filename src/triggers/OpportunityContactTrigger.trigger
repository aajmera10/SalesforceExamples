trigger OpportunityContactTrigger on Opportunity (before insert, before update) {
    set<Id> AccountIds = new set<Id>();
    for (Opportunity  o: trigger.new) {
        AccountIds.add(o.AccountId);
    }
    map<Id, Account> AccountContactMap = new map<Id, Account>();
    list<Account> AccConts = new list<Account>();
    AccConts = [Select Id, Name, (Select Id, FirstName,LastName, Master__c from Contacts Where Master__c = true) from Account where Id IN : AccountIds];
    for(Account acc : AccConts){
        AccountContactMap.put(acc.Id, acc);
    }
    for (Opportunity  o: trigger.new) {
        if(o.Primary_Contact_Opportunity__c == null){
            Account Acc = AccountContactMap.get(o.AccountId);
            if(Acc != null){
                List<Contact> conts = new list<Contact>(Acc.Contacts);
                if(conts.size() == 1){
                    o.Primary_Contact_Opportunity__c = conts[0].FirstName;
                }
            }
        }
    }
}