public class TestControllerAssignment {  
    public Contact con{get;set;}
    public ApexPages.StandardSetController cont{get; set;}
    public Integer size{get;set;}
    private String sortDirection = 'ASC';
    private String sortExp = 'name';
    public String searchString{get;set;}
    public List<SelectOption> paginationSizeOptions{get;set;}
    
    public String sortExpression
    {
        get
        {
            return sortExp;
        }
        set
        {
            //if the column is clicked on then switch between Ascending and Descending modes
            if (value == sortExp)
                sortDirection = (sortDirection == 'ASC')? 'DESC' : 'ASC';
            else
                sortDirection = 'ASC';
            sortExp = value;
        }
    }
    
    public String getSortDirection()
    {
        //if not column is selected 
        if (sortExpression == null || sortExpression == '')
            return 'ASC';
        else
            return sortDirection;
    }
    
    public void setSortDirection(String value)
    {  
        sortDirection = value;
    }
    
    public TestControllerAssignment(){
        
        size=10; 
        
        paginationSizeOptions = new List<SelectOption>();
        paginationSizeOptions.add(new SelectOption('10','10'));
        paginationSizeOptions.add(new SelectOption('20','20'));
        paginationSizeOptions.add(new SelectOption('30','30'));
        queryData();
    }
    
    public List<Contact> contacts{  
        get  
        {  
            if(cont != null)  
                return (List<Contact>)cont.getRecords();  
            else  
                return null ;  
        }  
        set;
    }
    public void queryData(){
        size=10; 
        string sortFullExp = sortExpression  + ' ' + sortDirection;
      
        con = new Contact();
        contacts = new List<Contact>();
        String query= '';
        contacts = [SELECT id,FirstName,LastName,Master__c,Account.Name FROM Contact];
        //query = 'Select name ,id, phone from Account '+strFilter+ ' limit 1000'; '+strFilter+ '
        query = 'SELECT id,FirstName,LastName,Master__c,Account.Name FROM Contact ORDER BY ' + sortFullExp +' limit 1000';
        System.debug('Query ---->'+ query );
        cont = new ApexPages.StandardSetController(Database.getQueryLocator(query)); 
        cont.setPageSize(size);
    }
    public void Search()
    {
        String query= '';
        String strFilter = '';
        string sortFullExp = sortExpression  + ' ' + sortDirection;
        // if(con.LastName != null && (con.LastName).trim() !='')
        //   {
        // 
        // }
        /* if(con.Account.Name != null && (con.Account.Name).trim() !='' )
{
if(strFilter == '')
{ 
strFilter  = strFilter  +  ' where Accou like \''+con.Account.Name+'%\'' ;
}
else
{
strFilter  = strFilter  +  ' And Phone like \''+con.Account.Name+'%\'' ;
}
}*/
        // if(strFilter != '')
        // {
        strFilter  = strFilter  +  ' where LastName Like \''+String.escapeSingleQuotes(searchString)+'%\''+'OR FirstName LIKE \''+String.escapeSingleQuotes(searchString)+'%\''+'OR Account.Name LIKE \''+String.escapeSingleQuotes(searchString)+'%\'' ;
        query = 'SELECT id,FirstName,LastName,Master__c,Account.Name FROM Contact '+strFilter+ 'ORDER BY '+ sortFullExp + ' limit 1000';
        System.debug('Query ---->'+ query );
        cont = new ApexPages.StandardSetController(Database.getQueryLocator(query)); 
        cont.setPageSize(size);
        //}
        // else
        //  {
        //  }
        // return null;
    }
    
    
    public void save(){
        try{
            update contacts;
        }catch(Exception e){
            Apexpages.addMessage(new Apexpages.message(ApexPages.Severity.Error,e.getMessage()));
        }   
    }
    
    public Boolean hasNext  
    {  
        get  
        {  
            return cont.getHasNext();  
        }  
        set;  
    }  
    public Boolean hasPrevious  
    {  
        get  
        {  
            return cont.getHasPrevious();  
        }  
        set;  
    }  
    public Integer pageNumber  
    {  
        get  
        {  
            return cont.getPageNumber();  
        }  
        set;  
    } 
    
    public void first(){
        cont.first();
        cont.getRecords();
        cont.save();
    }
    
    public void last(){
        cont.last();
        cont.getRecords();
        cont.save();
    }
    
    public void previous()  
    {  
        cont.save();
        cont.getRecords();
        cont.previous();  
    }
    
    public void next()  
    {  
        cont.save();
        cont.getRecords();
        cont.next();  
    }
    
    public void refreshPageSize() 
    {
        cont.save();
        cont.setPageSize(size);  
    }
    
}