public class SingleValueSaveController {
    public Contact con{get;set;}
    public String searchString{get;set;}
    public ApexPages.StandardSetController cont{get; set;}
     public boolean displayPopup {get; set;} 
    list <contact> conList;
    
    public SingleValueSaveController(){
       conlist=new List<contact>();
    }
    
    public PageReference save(){
        Contact conObj = new Contact(lastname = searchString);
        conlist.add(conObj);
        try{
            insert conList;
            showPopup();
        }catch(exception e){
             Apexpages.addMessage(new Apexpages.message(ApexPages.Severity.Error,e.getMessage()));
        }
        return null;
    }
    
     public void closePopup() {        
        displayPopup = false; 
         
    }     
    public void showPopup() {        
        displayPopup = true;    
    }
    
}