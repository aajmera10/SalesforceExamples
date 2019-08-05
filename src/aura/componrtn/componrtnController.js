({
    
    doInit: function(component, event, helper) {
        helper.getMetadata(component);
    },
    
    deletemap: function(component, event, helper) {
        if(confirm('Are you sure?'))
            helper.deleteMapping(component,event);
    },
    
    showSpinner: function(component, event, helper) {
        component.set("v.Spinner", true); 
    },
    
    hideSpinner : function(component,event,helper){
        component.set("v.Spinner", false);
    },
    
    handleNewButtonClick: function( component, event, helper ){
        helper.saveContactMap(component,event);
    },
    
    openEditModal: function(component, event, helper){
        var target = event.target;
        var rowIndex = target.getAttribute("data-row-index");
        component.set("v.mappingObj",component.get("v.wrapperList")[rowIndex].mappingObj);
        var con = component.get("v.mappingObj");
        console.log('data:',component.get("v.mappingObj"));
        console.log(JSON.parse(JSON.stringify(con)));
        component.set("v.isOpen",true);
    },
    
    openModal: function( component, event, helper ){
        component.set("v.mappingObj",{'sobjectType':'Contact_Mapping__c', 
                                      'Contact_Field__c': '',
                                      'isInsert__c': false,
                                      'isUpdate__c': false,
                                      'isGet__c': false, 
                                      'Name': '',
                                      'Decipher_Name__c':''});
        var con = component.get("v.mappingObj");
        console.log('data:',component.get("v.mappingObj"));
        console.log(JSON.parse(JSON.stringify(con)));
        component.set("v.isOpen",true);
    },
    closeModal: function( component, event, helper ){
        component.set("v.isOpen",false);
        component.set("v.Spinner", false);
    },
    
})