public virtual class VCC_ControllerBase 
{
    //getter and setter method to set the key of the Component Map
    public String key
    {   
        get;
        set{
            if(value != null)
            {
                Key = value;
                if(pageController != null)
                    pageController.setComponentControllerMap(Key, this);
            }
        }
    }
   
    //getter and setter method to set the Page Controller
    public VFC_ControllerBase pageController
    { 
        get;
        set {
            if (value != null) 
            {
                pageController = value;
                if (Key != null )
                    pageController.setComponentControllerMap(Key, this);
            }     
        }
    }
}