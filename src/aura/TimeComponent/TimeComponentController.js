({
    doInit : function(component, event, helper) {
        var today = new Date();
        component.set('v.currentDate', today);

        var timezone = $A.get("$Locale.timezone");
        console.log('Time Zone Preference in Salesforce ORG :'+timezone);
        var mydate = new Date().toLocaleString("en-US", {timeZone: timezone})
        console.log('Date Instance with Salesforce Locale timezone : '+mydate);
        
        var localDate = new Date();
        console.log('Local Date in Your Laptop : '+localDate);
        var timezone = localDate.getTimezoneOffset();
        console.log(timezone); 
    }
})