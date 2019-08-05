global class LeadProcessor implements Database.Batchable<sObject>, Database.Stateful {
    global Integer recordsProcessed = 0;
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT ID,Name,LeadSource FROM Lead' 
        );
    }
    global void execute(Database.BatchableContext bc, List<Lead> scope){
        // process each batch of records
        for (Lead l : scope) {
            l.LeadSource='DreamForce';
        }
        update scope;
    }    
    
    global void finish(Database.BatchableContext bc){
        // execute any post-processing operations
       ID job= bc.getJobId();
        System.debug(job);
    }  
}