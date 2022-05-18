public class Utils_Sorter 
{
    private Map<String, Integer> listPosition = new Map<String, Integer>();   
    private Map<String, List<String>> sortedFieldValuesPerFieldName = new Map<String, List<String>>();     
    private Map<String, Map<String, List<String>>> sObjectIDsPerFieldNames = new Map<String, Map<String, List<String>>>();
    public List<sObject> originalList {get; set;}
    
    /* Constructor */
    public Utils_Sorter() 
    {
        originalList = null;
    }
    
    /* Gets the List<Sobject>, column to be sorted & sorting order and calls the makeSortedList method */
    public List<sObject> getSortedList(List<sObject> originalList, String fieldName, Boolean ascending) 
    {
        System.Debug('****** Getting List of Sobjects and sorting order Begins ******');
        this.originalList = originalList;
        sortedFieldValuesPerFieldName = null;
        fieldName = fieldName.toUpperCase(); 
        System.Debug('****** Getting List of Sobjects and sorting order Ends ******');
        return makeSortedList(fieldName, ascending);
    }
    
    /* Initalizing values */
    private void InitializeFieldName(String fieldName) 
    {
        System.Debug('****** Intializing values Begins ******');
        String sObjectID;
        Integer position;
        String fieldValue;
        Integer i=0;
        List<String> sObjectIDs = new List<String>();
        Set<String> valuesForFieldSet = new Set<String>();    
        List<String> valuesForFieldList = new List<String>();
        Map<String, List<String>> sObjectIDsPerFieldValues = new Map<String, List<String>>();
        
        if (sortedFieldValuesPerFieldName == null) 
        {
            listPosition = new Map<String, Integer>();
            sortedFieldValuesPerFieldName = new Map<String, List<String>>();
            sObjectIDsPerFieldNames = new Map<String, Map<String, List<String>>>();
        }
        sObjectIDsPerFieldValues = sObjectIDsPerFieldNames.get(fieldName);
        if (sObjectIDsPerFieldValues == null) 
        {
            sObjectIDsPerFieldValues = new Map<String, List<String>>();
            sObjectIDsPerFieldNames.put(fieldName, sObjectIDsPerFieldValues);
        }
        if (!sortedFieldValuesPerFieldName.keySet().contains(fieldName)) 
        {
            position = 0;
            valuesForFieldSet = new Set<String>();
            listPosition = new Map<String, Integer>();
            
            for (sObject sObj : originalList) 
            {
                sObjectID = String.ValueOf(i++);
                fieldValue = getValue(sObj, fieldName);
                listPosition.put(sObjectID, position++);
                valuesForFieldSet.add(fieldValue);
                sObjectIDs = sObjectIDsPerFieldValues.get(fieldValue);
                if (sObjectIDs == null) 
                {
                    sObjectIDs = new List<String>();
                    sObjectIDsPerFieldValues.put(fieldValue, sObjectIDs);
                }
                sObjectIDs.add(sObjectID);
            }
            valuesForFieldList = new List<String>();
            valuesForFieldList.addAll(valuesForFieldSet);
            valuesForFieldList.sort();
            sortedFieldValuesPerFieldName.put(fieldName, valuesForFieldList);
        }
        System.Debug('****** Intializing values Ends ******');
    }
    /* This method sorts the List<Sobject> in the corresponding sorting order */
    private List<sObject> makeSortedList(String fieldName, Boolean ascending) 
    {
        System.Debug('****** sorting the List of Sobject Begins ******');
        Integer position;
        List<String> sObjectIDs = null;
        List<String> valuesForFieldList = null;        
        InitializeFieldName(fieldName);        
        List<sObject> outputList = originalList.clone();
        outputList.clear();        
        valuesForFieldList = sortedFieldValuesPerFieldName.get(fieldName);
        
        for (String fieldValue : valuesForFieldList) 
        {
            sObjectIDs = sObjectIDsPerFieldNames.get(fieldName).get(fieldValue);

            for (String ID : sObjectIDs) 
            {
                position = listPosition.get(Id);               
                if ((ascending) || (outputList.size()==0)) 
                {
                    outputList.add(originalList[position]);
                } else 
                {
                    outputList.add(0, originalList[position]);
                }
            }
        }
        System.Debug('****** sorting the List of Sobject Ends ******');
        return outputList;
    }
    /* This returns the sObject desired in case the fieldName refers to a linked object.*/
    private static String getValue(sObject sObj, String fieldName) 
    {
        System.Debug('****** returning of sObject Begins ******');
        Integer pieceCount;
        String[] fieldNamePieces;        
        fieldNamePieces = fieldName.split('\\.');
        pieceCount = fieldNamePieces.size();
        for (Integer i = 0; i < (pieceCount-1); i++) 
        {
            sObj = sObj.getSObject(fieldNamePieces[i]);
        }
        System.Debug('****** returning of sObject Ends ******');
        return String.valueOf(sObj.get(fieldNamePieces[pieceCount-1]));
    }
}