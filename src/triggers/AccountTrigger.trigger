trigger AccountTrigger on Account (before insert,before update,before delete,after insert) {
    if(Trigger.isBefore){
        if(Trigger.isInsert ){
            AccountTriggerHandler.testSimilar(Trigger.New);
            AccountTriggerHandler.isActiveTrigger(Trigger.New);
        }
        if(Trigger.isDelete){
            AccountTriggerHandler.accountshouldnotdelete(Trigger.Old);
        }
        if(Trigger.isUpdate){
            //AccountTriggerHandler.testSimilar(Trigger.New);
            AccountTriggerHandler.isActiveTrigger(Trigger.New);
            AccountTriggerHandler.accountOutofPostalCode(Trigger.new,Trigger.OldMap,Trigger.NewMap);
        }
    }
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            AccountTriggerHandler.onlyDefaultContactTrigger(Trigger.new);
        }
    }
}