public virtual interface Utils_PicklistManager
{
    // Return dependent picklist value 
    List<SelectOption> getPicklistValues(Integer i, String S);
    
    // Return name of the levels
    list<String> getPickListLabels();
}