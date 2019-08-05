({
    doInit: function(component, event, helper) {
        helper.fetchpicklistValue(component, event);
    },
    showSpinner: function(component, event, helper) {
        component.set("v.Spinner", true); 
    },
    cancelClickHandler : function(component, event, helper) {
        $A.get("e.force:closeQuickAction").fire();
    },
    hideSpinner : function(component,event,helper){
        component.set("v.Spinner", false);
    },
    updateContact : function(component,event,helper){
        console.log('someting ssdd')
        var pickval = component.get("v.status");
        console.log('pickval ssdd' +pickval)
        if (pickval == 'Closed') {  
            var inputAge = component.find('reasontovalid');
            if(inputAge.get("v.validity").valid){
                console.log('someting else')
                component.set("v.warningModal",true);
                //helper.saveValue(component);
            }else{
                console.log('someting null')
                inputAge.showHelpMessageIfInvalid();              
            }
        }else{
            helper.saveValue(component);
        }
    },
    acceptWarning: function(component,event,helper){
        helper.saveValue(component);
    },
    cancelWarning: function(component,event,helper){
         component.set("v.warningModal",false);
    }
})