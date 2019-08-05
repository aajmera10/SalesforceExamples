trigger ContactTrigger on Contact (before insert,before update, after insert,after update, after Delete, before Delete) {
    if(Trigger.isBefore && trigger.isInsert){
        ContactTriggerHandler.checkDuplicateContact(Trigger.new);
        ContactTriggerHandler.websiteTrigger(Trigger.New);
        ContactTriggerHandler.onBeforeInsert(Trigger.New);
        //ContactTriggerHandler.contactAccountIsActive(Trigger.New);
    }
    if(Trigger.isBefore && trigger.isUpdate){
        ContactTriggerHandler.checkDuplicateContact(Trigger.new);
        ContactTriggerHandler.websiteTrigger(Trigger.New);
        ContactTriggerHandler.onBeforeUpdate(Trigger.New, Trigger.Oldmap);
    }
    if(Trigger.isAfter &&(trigger.isInsert || trigger.isUpdate)){
        //ContactTriggerHandler.moreThanOneContact(Trigger.new);
        //ContactTriggerHandler.totalSalaryTrigger(Trigger.New);
        
    }
    if(Trigger.isAfter && Trigger.isDelete){
        ContactTriggerHandler.totalSalaryTrigger(Trigger.Old);
    }
    
}

/*for(Contact con : trigger.new){
accountId.add(con.AccountId);      
}
Map<Id, Contact> newMap = new Map<Id,Contact>([SELECT id,LastName,Master__c,AccountId FROM Contact WHERE Master__c=true AND AccountId IN:accountId]);
//System.debug(newMap.size());
// System.debug(newMap);
// List<Contact> contactList =[SELECT id,LastName,Master__c,AccountId FROM Contact WHERE Master__c=true AND AccountId =:accountId];
if(newMap.size()>0){
for(Contact cont:Trigger.New){
//for(Contact contDup:contactList){
// if (contDup.AccountId==cont.AccountId  && contDup.id!=cont.Id){
//if(contDup.id==cont.Id){
if(newMap.containsKey(cont.id)!=null && cont.Master__c==true){
cont.addError('Duplicate Deceted');  
}
}                	
}*/
//}
/*for(Contact con:Trigger.new){
//AND id!=:con.Id//
if(con.Master__c==true){
//con.addError('Already has a master Contact');
List<Contact> contactList =[SELECT id,LastName,Master__c FROM Contact WHERE Master__c=true AND AccountId = :con.AccountId AND id!=:con.Id];
if(contactList.size()>0){
con.addError('Duplicate Deceted');
}
}}*/


/* for(Contact con:Trigger.new){
//AND id!=:con.Id//
if(con.Master__c==true){
//con.addError('Already has a master Contact');
List<Contact> contactList =[SELECT id,LastName,Master__c FROM Contact WHERE Master__c=true AND AccountId = :con.AccountId AND id!=:con.Id];
if(contactList.size()>0){
con.addError('Duplicate Deceted');
}
//////////////
//if(contactList.size()>0){
for(Contact cont:Trigger.New){
for(Contact contDup:contactList){
if (contDup.AccountId!=cont.AccountId && contDup.id!=cont.Id)
{

}
}                	
}
}
//
}
}
}*/
//}

/* if(accountId != null){
Map<Id,Contact> contactMap = new Map<Id,Contact>([SELECT Id, FirstName,LastName,Master__c 
FROM Contact where Master__c=TRUE AND AccountId =:accountId]);
for(Contact c: Trigger.New){
if(c.Master__c==true){
Contact cont =contactMap.get(c.id);
cont.id = c.Id;
}

}

}*/