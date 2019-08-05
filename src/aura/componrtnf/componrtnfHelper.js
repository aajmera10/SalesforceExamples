({
    getMetadata: function(component) {
        var action = component.get('c.getContactMetadataDetail');
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('state--'+state);
            if(state == "SUCCESS"){
                var result = response.getReturnValue();
                component.set("v.mappings",result[0].contactFieldsList);
                this.fetchPickListVal(component, 'Decipher_Name__c');
                component.set("v.wrapperList",result);
                
            } else if(state == "ERROR"){
                alert('Error in calling server side action');
            }
        });
        $A.enqueueAction(action);
    },
    
    deleteMapping: function(component,event) {
        component.set("v.Spinner", true);
        console.log('event.target.id',event.target.id);
        var action = component.get("c.deleteMappings");
        action.setParams({recordId:event.target.id});
        action.setCallback(this, function(response) {
            var responseState = response.getState();
            if(responseState === 'SUCCESS'){
                var storeResponse = response.getReturnValue();
                //component.set("v.wrapperList",storeResponse);
                this.getMetadata(component);
                component.set("v.Spinner", false);                
            }else if(responseState === 'ERROR'){
                component.set("v.Spinner", false);
                var errors = response.getError();
                alert('Error is'+errors[0].getmessage);
            }
            
        });
        $A.enqueueAction(action); 
    },
    
    saveContactMap : function(component, event) {
        var validContactMapping = component.find('fieldtovalidate').reduce(function (validSoFar, inputCmp) {
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;
        }, true);
        if(validContactMapping){
            component.set("v.Spinner", true);
            var con = component.get("v.mappingObj");
            var action = component.get("c.saveMappings");
            action.setParams({
                mappingObj : con
            });
            action.setCallback(this,function(response){
                var state = response.getState();
                if(state === "SUCCESS"){
                    var storeResponse = response.getReturnValue();
                    console.log('>>>'+storeResponse.isError);
                    this.showToastMessage (storeResponse.message, storeResponse.type, storeResponse.label);
                    if(storeResponse.isError){
                        component.set("v.isOpen",true);
                    }else{
                        component.set("v.Spinner", false);
                        component.set("v.isOpen",false);
                    }
                    this.getMetadata(component);
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
        }
    },
    
    fetchPickListVal: function(component, fieldName) {
        var action = component.get("c.getselectOptions");
        action.setParams({
            "objObject": component.get("v.mappingObj"),
            "fld": fieldName
        });
        var opts = [];
        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                var allValues = response.getReturnValue();
                
                if (allValues != undefined && allValues.length > 0) {
                    opts.push({
                        label: "--- None ---",
                        value: ""
                    });
                }
                for (var i = 0; i < allValues.length; i++) {
                    opts.push({
                        label: allValues[i],
                        value: allValues[i]
                    });
                }
                component.set("v.mappingObjname",allValues);
            }
        });
        $A.enqueueAction(action);
    },
    
    showToastMessage : function  (msg, type, label){
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": label,
            "message": msg,
            "type" : type
        });
        toastEvent.fire();
    },
    
})