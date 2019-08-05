public class FilterSearch  
{
    public String searchString{get;set;}
    public Boolean showResult{get;set;}
    public Integer noOfRecords{get; set;}


    public Integer size{get;set;}
    String errorStr = '';    
    public ApexPages.StandardSetController setCon{get;set;}    
    public List<SelectOption> paginationSizeOptions{get;set;}


    /**
    * FilterSearch
    * Constructor to initiate the default values at the time of Loading
    */    
    public FilterSearch()
    {
        searchString = ApexPages.currentPage().getParameters().get('searchText');

        size=10;

        paginationSizeOptions = new List<SelectOption>();
        paginationSizeOptions.add(new SelectOption('10','10'));
        paginationSizeOptions.add(new SelectOption('20','20'));
        paginationSizeOptions.add(new SelectOption('30','30'));
        showAll();        
    }

    public void showAll()
    {
        try
        {
            if(String.isNotBlank(searchString))
            {  
                //change your query here, just to show you I have omitted the searchString
                String query='Select Id,Name, account.name, stagename, ForecastCategoryName FROM Opportunity LIMIT 1000';
                setCon = new ApexPages.StandardSetController(Database.getQueryLocator(query));            
                if(setCon.getResultSize() >0)
                {
                showResult = true;
                }else{
                    showResult = false;
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'No Records Found.'));
                }        
            }            
        }catch(Exception ex)
        {
            errorStr ='Error Occured while Searching.';
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'errorStr:' +ex.getMessage()));
        }   
    }

    public List<Opportunity> getOpps() 
    {
        if(setCon.getResultSize() >0)
        {
          setCon.setPageSize(size);  
          noOfRecords = setCon.getResultSize();
          return (List<Opportunity>)setCon.getRecords();
        }else
        {
          return null;
        }
       // return null;
    }

    /**
    * refreshPageSize
    * Changes the size of Pagination.
    * @param    
    * @return void
    */
    public void refreshPageSize() 
    {
        setCon.setPageSize(size);         
    }
}