({
    doInit: function (cmp, evt, helper){
        let vfOrigin = "https://playful-shark-s3udin-dev-ed--c.eu5.visual.force.com";
        window.addEventListener("message", function(event) {
            console.log(event.data);
       
            if (event.data==="Unlock"){ 
                alert('ShivKant Bhai')
              let myButton = cmp.find("myButton");
                myButton.set('v.disabled', false);
                 console.log("event.data");
            }            
        }, false);                
    },
    doSubmit: function (cmp, evt, helper){
        alert("Do Submit");
    }
    
})