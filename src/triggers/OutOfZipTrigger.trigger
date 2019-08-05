trigger OutOfZipTrigger on Account (before update) {
    
    Set<Id> accIds = new Set<Id>();
    List<Contact> conList = new List<Contact>();
    for(Account a: trigger.new){        
        if(a.BillingStreet != trigger.oldMap.get(a.id).BillingStreet || a.BillingCity!= trigger.oldMap.get(a.id).BillingCity || 
           a.BillingState != trigger.oldMap.get(a.id).BillingState || a.BillingPostalCode != trigger.oldMap.get(a.id).BillingPostalCode)
        {
            accIds.add(a.Id);
        }
        
        if(!accIds.isEmpty())
        {
            conList = [Select Id,AccountId,MailingPostalCode from contact where AccountId IN: accIds];
        }
        
        for(contact con : conList)
        {
            Account accrec = trigger.newMap.get(con.AccountId);
            if(con.MailingPostalCode != accrec.BillingPostalCode)
            {
                //accrec.Out_of_Postal__c = True;
            }
        }
        
    }
}