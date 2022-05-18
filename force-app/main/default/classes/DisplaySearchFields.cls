public class DisplaySearchFields extends VCC_ControllerBase
{
    final public static integer MAX_NUMBER_OF_PL = 7;
    public String pickListType{get;set;}
    Public Utils_PicklistManager plManager;
    public List<String> searchFilter{get;set;}
    public integer pickListCount{get;set;}
    public string InitSearch{get;set;}
    public string searchText{get;set;}       
    public String Init{set; get{init(); return null;}}
    public string CurrentLevel{get;set;}
    public Boolean Clear=false;
    Public List<String> Levels{get;set;} 
    public String level1{set{if(value != null){Level1 = value; Levels[0]=value; }} get{return Levels[0];}}
    public String level2{set{if(value != null){Level2 = value; Levels[1]=value;}} get{return Levels[1];}}
    public String level3{set{if(value != null){Level3 = value; Levels[2]=value;}} get{return Levels[2];}}
    public String level4{set{if(value != null){Level4 = value; Levels[3]=value;}} get{return Levels[3];}}
    public String level5{set{if(value != null){Level5 = value; Levels[4]=value;}} get{return Levels[4];}}
    public String level6{set{if(value != null){Level6 = value; Levels[5]=value;}} get{return Levels[5];}}
    public String level7{set{if(value != null){Level7 = value; Levels[6]=value;}} get{return Levels[6];}}        
    
    Public List<String> Labels{get;set;}
    public String level1Label{set; get{return Labels[0];}}
    public String level2Label{set; get{return Labels[1];}}
    public String level3Label{set; get{return Labels[2];}}
    public String level4Label{set; get{return Labels[3];}}
    public String level5Label{set; get{return Labels[4];}}
    public String level6Label{set; get{return Labels[5];}}
    public String level7Label{set; get{return Labels[6];}}   
                
    public List<List<SelectOption>> items = new List<List<SelectOption>>();
    public List<SelectOption> items1{set; get{return items[0];}}
    public List<SelectOption> items2{set; get{return items[1];}}
    public List<SelectOption> items3{set; get{return items[2];}}
    public List<SelectOption> items4{set; get{return items[3];}}        
    public List<SelectOption> items5{set; get{return items[4];}}
    public List<SelectOption> items6{set; get{return items[5];}}
    public List<SelectOption> items7{set; get{return items[6];}}
       
    public PageReference Init()
    { 
        /*
        if(clear==false)
        {
            for(Integer index=1; index<items.size(); index++)
            {
                if(items[index].size()>0)
                    return null; 
            }
        }
        */
        
        Clear=false;
        pickListCount = 1;
        Labels = new List<String>();
        Levels = new String[MAX_NUMBER_OF_PL];
        Items.clear();
        searchText = InitSearch;
        
        For(Integer index=0;index<MAX_NUMBER_OF_PL;index++)
            Items.add(new List<SelectOption>());
        
        if(pickListType != NULL)
        {
        plManager = Utils_Factory.getPickListManager(pickListType);
        if( plManager != null)
        {
            Labels = plManager.getPickListLabels();  
            Items[0] = plManager.getPicklistValues(1, null);
            
        }
        }
        if(searchFilter == null)
            return null;
        
        if(searchFilter.size()>0)
        {
            for(Integer index=0; index<searchFilter.size(); index++)
            {
                for(Integer indexOptions=0; indexOptions<items[index].size();indexOptions++)
                {
                    if(searchFilter[index] == null || searchFilter[index] == items[0][0].getvalue())
                        break;
                    
                    if(items[index][indexOptions].getlabel().trim() == searchFilter[index].trim() || items[index][indexOptions].getvalue().trim() == searchFilter[index].trim())
                    {
                        items[index+1] = plManager.getPicklistValues(index+2,items[index][indexOptions].getvalue());
                        Levels[index] = items[index][indexOptions].getvalue();
                        pickListCount = index+2;
                        break;
                    }
                }
                
                if(pickListCount != index+2)
                    break;
            }
        }
        return null;
    }   
           
    public void picklistRefresher() 
    { 
        Integer Level = Integer.valueof(system.currentpagereference().getParameters().get('level'));
        
        System.debug('#### Level :' + Levels[Level-1]);
        
        if(Levels[Level-1] == items[0][0].getvalue())
        {
            For(integer index=Level; index<MAX_NUMBER_OF_PL; index++)
            {                
                items[index] = new List<SelectOption>();
                Levels[index] = null;
                pickListCount = Level;
            }
        }
        else
        {          
            items[Level] = plManager.getPicklistValues(Level+1, Levels[Level-1]);
            
            For(integer index=Level+1; index<MAX_NUMBER_OF_PL; index++)
            {
                items[index].clear();
                Levels[index]=null;
            }
            pickListCount = Level+1; 
        }
    }
    
    public PageReference clear()
    {
        System.debug('#### CLEAR METHOD');
        searchFilter = null;
        InitSearch = null;
        Clear = true;
        return Init();
    }
}