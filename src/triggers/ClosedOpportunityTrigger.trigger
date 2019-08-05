trigger ClosedOpportunityTrigger on Opportunity (after insert) {
    List<Task> task =new List<Task>();
    for(Opportunity opp:Trigger.new){
        if(opp.StageName=='Closed Won'){
           Task t = new Task();
            t.Subject='Follow Up Test Task';
            t.WhatId = opp.Id;
            task.add(t);
        }
    }
    insert task;
}