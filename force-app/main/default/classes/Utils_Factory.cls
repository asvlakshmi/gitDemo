public class Utils_Factory
{
    public static Utils_DataSource getDataSource(String arg0)
    {
         if(arg0 == Label.CL00011 )
            return new ProductDataSource(); 
         else if(arg0 == 'COMP')
            return new competitorDataSource();          
          else
             return null;
    }
    
    public static Utils_PicklistManager getPickListManager(String arg1)
    {
         if(arg1 == Label.CL00011 )
            return new ProductPicklistManager();
         else if(arg1 == 'COMP' )
            return new CompetitorPicklistManager();   
         else
             return null;
    }
}