public virtual class VFC_ControllerBase 
{
    public Map<String, VCC_ControllerBase> componentControllerMap = new Map<String, VCC_ControllerBase>();
    public Integer ActionNumber;
    
    //Getter method for current VF Page Controller
    public VFC_ControllerBase getThis() 
    {
        return this;
    }
    
    //getter method for the hashmap to return the list of component controller(s)
    public virtual Map<String, VCC_ControllerBase> getComponentControllerMap(){
        //System.debug('####GGA b(prime) : getcomponentControllerMap()  ');
        return componentControllerMap;
    }
    
    //Setter method to set the Component controller value
    public virtual void setComponentControllerMap(String key, VCC_ControllerBase comp)
    {
        if(componentControllerMap == null)
              componentControllerMap = new Map<String, VCC_ControllerBase>();
        
        componentControllerMap.put(key,comp);
    }  
   
    // Generic virtual Controller methods which can be called from the component
    //public virtual void PerformAction(String S, VFC_ControllerBase CB){} 
    public virtual pagereference PerformAction(sObject Obj, VFC_ControllerBase CB){return null;}  
    //public virtual void PerformAction(List<String> SList, VFC_ControllerBase CB){}
    //public virtual void PerformAction(List<sObject> ObjList, VFC_ControllerBase CB){}
}