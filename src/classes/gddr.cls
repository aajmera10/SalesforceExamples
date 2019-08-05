public class gddr {
    @AuraEnabled
    public static void supra(String Id,String status,String reason){
        if(String.isNotBlank(Id)){
            
            Contact conObj = [SELECT Id,status__c,Reason__c From Contact WHERE Id =: Id] ;
            conObj.status__c = status;
            conObj.Reason__c = reason;
            update conObj;
        }
    }
    @AuraEnabled
    public static WrapperClass getStatus(String Id){
        if(String.isNotBlank(Id)){
        List < String > allOpts = new List<String>();
        Contact contacts =[SELECT Id,status__c,Reason__c FROM Contact WHERE Id =: Id];
        system.debug('contacts'+contacts);
        Schema.sObjectType objType = Contact.getSObjectType();
        Schema.DescribeSObjectResult objDescribe = objType.getDescribe();
        map < String, Schema.SObjectField > fieldMap = objDescribe.fields.getMap();
        list < Schema.PicklistEntry > values = fieldMap.get('status__c').getDescribe().getPickListValues();
        System.debug('valsss'+values);
        for (Schema.PicklistEntry a: values) {
            allOpts.add(a.getValue());
        }
        allOpts.sort();
        System.debug('allOpts  '+allOpts);
        WrapperClass wrapperClass = new WrapperClass(contacts,allOpts);
        System.debug('wrapperClass'+wrapperClass);
        return wrapperClass;            
        }
        else{
            return null;
        }
    }
    
    private class WrapperClass{
        @AuraEnabled public List<String> contactFieldsList {get;set;}
        @AuraEnabled public Contact contactObj {get;set;}
        
        private WrapperClass(Contact contactObj, List<String> contactFieldsList) {
            this.contactObj = contactObj;
            this.contactFieldsList = contactFieldsList;
        }  
    }
}

/*
public class gddr {
@AuraEnabled
public static void supra(String Id,String status,String reason){
if(String.isNotBlank(Id)){

Contact conObj = [SELECT Id,status__c,Reason__c From Contact WHERE Id =: Id] ;
conObj.status__c = status;
conObj.Reason__c = reason;
update conObj;
}
}
@AuraEnabled
public static wrapperClass getStatus(String currentRecordId){
wrapperClass wrapperClass = new wrapperClass();
System.debug('userinfo.getProfileId  '+userinfo.getProfileId());
List <String> allOpts =  wrapperClass.contactFieldsList;
Contact contacts =[SELECT Id,status__c,Reason__c FROM Contact WHERE Id =:currentRecordId];
Schema.sObjectType objType = Contact.getSObjectType();
Schema.DescribeSObjectResult objDescribe = objType.getDescribe();
map < String, Schema.SObjectField > fieldMap = objDescribe.fields.getMap();
list < Schema.PicklistEntry > values = fieldMap.get('status__c').getDescribe().getPickListValues();
for (Schema.PicklistEntry a: values) {
allOpts.add(a.getValue());
}
allOpts.sort();
if(contacts.status__c != '' && contacts.status__c !=null && contacts.Reason__c!='' && contacts.Reason__c!=null){
allOpts.add(contacts.status__c);
contacts.Reason__c = wrapperClass.reason;
}
else{
allOpts.add('-- None --');
}
System.debug('allOpts  '+allOpts);
return wrapperClass;
}

public class wrapperClass{
@AuraEnabled public List<String> contactFieldsList {get;set;}
@AuraEnabled public String reason {get;set;}
}
}
*/