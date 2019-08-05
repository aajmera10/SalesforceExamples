({
    fetchpicklistValue: function(component, event) {
        var action = component.get("c.getStatus");
        action.setParams({
            'Id': component.get("v.recordId"),
        });
        var opts = [];
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('state--'+state);
            if (response.getState() == "SUCCESS") {
                console.log('response.getReturnValue()'+response.getReturnValue());
                var allValues = response.getReturnValue();
                component.set("v.mappingObjname",allValues.contactFieldsList);
                
                console.log('response'+allValues.contactObj.status__c);
                component.set("v.status",allValues.contactObj.status__c);
                component.set("v.reason",allValues.contactObj.Reason__c);
                
                
            }else if(state === "ERROR"){
                    var errors = action.getError();
                    if (errors) {
                        if (errors[0] && errors[0].message) {
                            alert(errors[0].message);
                        }
                    }}
        });
        $A.enqueueAction(action); 
    },
    saveValue: function(component) {
        var inputAge = component.find('statustovalidate');
        if(inputAge.get("v.validity").valid){
            console.log('Not NULL');
            console.log('we are here');
            console.log(component.get("v.recordId")+component.get("v.status")+component.get("v.reason"));
            console.log('we are hersse');
            var action = component.get("c.supra");
            action.setParams({
                'Id': component.get("v.recordId"),
                'status': component.get("v.status"),
                'reason': component.get("v.reason")
            });
            action.setCallback(this,function(response){
                var state = response.getState();
                if(state === "SUCCESS"){
                    component.set("v.Spinner", false);
                    console.log('someting ss1');
                    this.showToastMessage (component,'success', 'Contact saved successfully.', 'success');    
                    console.log('someting sse');
                    if(storeResponse.isError){
                        console.log('someting ss');
                    }else{
                        
                    }
                } else if(state === "ERROR"){
                    var errors = action.getError();
                    if (errors) {
                        if (errors[0] && errors[0].message) {
                            alert(errors[0].message);
                        }
                    }
                }else if (status === "INCOMPLETE") {
                    alert('No response from server or client is offline.');
                }
            });       
            $A.enqueueAction(action);
            
        }else{
            console.log('NULL');
            inputAge.showHelpMessageIfInvalid();
        }
    },
    showToastMessage : function(component,title,message,type) {
        console.log('I am Here');
        var dismissActionPanel = $A.get("e.force:closeQuickAction");
        console.log('I am Here2');
        dismissActionPanel.fire();
        console.log('I am Here3');
        var toastEvent = $A.get("e.force:showToast");
        console.log('I am Here4');
        toastEvent.setParams({
            "title": title,
            "message": message,
            "type": type,
        });
        toastEvent.fire();
        console.log('I am Here5');
    },
    
})