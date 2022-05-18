public class DisplaySearchResults extends VCC_ControllerBase
{
    //Initializing variables
    public string columnHeader1{get;set;}
    public string columnHeader2{get;set;}
    public string columnHeader3{get;set;}
    public string columnHeader4{get;set;}
    public string columnHeader5{get;set;}
    public string columnHeader6{get;set;}
    public string columnHeader7{get;set;}
    public string columnHeader8{get;set;}
    public string columnHeader9{get;set;}
    public string columnHeader10{get;set;}
    public Integer recordsPerPage{get;set;}
    public Boolean Displayed{get;set;}
    public Integer noOfColumns{get;set;}
    public Boolean selType{get;set;}    
    public List<SelectOption> columnList{get;set;}
    public List<sObject> displayRecordList{get;set;}
    public Integer pageNumber;
    public sObject sObj ;
    public Set<Object> existingRecords{get;set;} 
    public List<String> FieldForKeyList{get;set;}   
    public Integer numberOfPages{get;set;}
    private String sortedBy;
    private Boolean sortStatus = true;
    private Utils_Sorter sorter = new Utils_Sorter();
    private boolean sortedList = true;
    public List<DataDisplayWrapper> searchResults{get;set;}      
    private boolean sortByDef= false;    
    private Map<String, String> columnSort = new Map<String, String>();
    public String col1Sort{get;set;}
    public String col2Sort{get;set;}
    public String col3Sort{get;set;}
    public String col4Sort{get;set;}
    public String col5Sort{get;set;}
    public String col6Sort{get;set;}                    
    public String col7Sort{get;set;}    
    public String col8Sort{get;set;}    
    public String col9Sort{get;set;}            
    public String col10Sort{get;set;}
    public Integer IDNumber{get;set;}
    public boolean sortingNotReqr{get;set;}
        
    public List<sObject> getSelectedObjects()
    {
        List<sObject> SelectedObjectList = new List<sObject>();
        for(DataDisplayWrapper DataWrapper:searchResults)
        {
                if(DataWrapper.selected==true)
                {
                    SelectedObjectList.add(DataWrapper.recordDisplayed);
                }
        }
        return SelectedObjectList;
    }
        
    public string getInit()
    {
        System.Debug('****** Init ******');
        Init();
        return null;
    }
    
    //Gets the page number
    public Integer getpageNumber()
    {
        System.Debug('****** Getting Page Number Begins ******');
        DataTemplate__c dt = new DataTemplate__c();
        if(pageNumber ==0)
            return 1;
        else if(pageNumber > numberOfPages)
            return numberOfPages;        
        else        
            return pageNumber;
    }
    //Sets the page number    
    public void setpageNumber(Integer pageNumber)
    {
        this.pageNumber = pageNumber;
    }
    /* Gets the component controller */
    public  DisplaySearchResults getComponentController()
    {
        System.Debug('****** getting the Component Controller ******');
        return this;
    }
    
    public DisplaySearchResults()
    {
         columnList = new List<SelectOption>(); 
         FieldForKeyList = new List<String>(); 
         searchResults = new List<DataDisplayWrapper>();  
    }
    
    //Start of Inner class
    public class DataDisplayWrapper extends VCC_ControllerBase
    {   
        public DataTemplate__c record{get; set;}
        public sObject recordDisplayed{get;set;}
        public Integer pageNumber{get; set;}
        public Boolean selected{get; set;}
        public Boolean DisableAction2{get;set;}
        public String KeyForExisting{get;set;}
        public Integer IDNumber{get;set;}

        /* This method will be called on click of Select Link in the VF page, calls the perform action
         * method of the page controller by passing the selected record in sObject[] format.
         */
        public pagereference Action1()
        { 
           this.pageController.ActionNumber=1;        
           return this.pageController.PerformAction(recordDisplayed,this.pageController);
        }
        
        public pagereference Action2()
        {    
           this.pageController.ActionNumber=2;
           DisableAction2 = true;
           return this.pageController.PerformAction(recordDisplayed,this.pageController);
        }         
        
        //Wrapper to Display Data
        public DataDisplayWrapper(sObject objects, Integer IndexID, Integer pageNumbers, List<SelectOption> columnList, VFC_ControllerBase vfcBase,Map<String, Schema.SObjectField> objFields, List<String> FieldForKeyList, set<Object> existingRecords, Map<String,Schema.DisplayType> objFieldTypes)
        {
            System.Debug('****** Initializing the Properties and Variables Begins for DataDisplayWrapper ******');
            this.recordDisplayed = objects;
            this.pageController = vfcBase;
            this.pageNumber = pageNumbers;
            this.IDNumber = IndexID;
            this.record = new DataTemplate__c();
            this.selected = false;
            system.debug('------existingRecords--------- '+existingRecords );
            System.debug('-------------ColumnList Size--------'+columnList.size());
            
            if(existingRecords!=null && FieldForKeyList!=null)
            {             
                For(integer index=0; index < FieldForKeyList.size(); index++)
                {
                    if(index==0)
                       KeyForExisting =  Utils_Methods.convertToString(objFields,objFieldTypes,objects,FieldForKeyList[index]);
                    else
                       KeyForExisting +=  Utils_Methods.convertToString(objFields,objFieldTypes,objects,FieldForKeyList[index]);
                }
               system.debug('------KeyForExisting --------- '+KeyForExisting );
                                
                // KeyForExisting
                if(existingRecords.contains(KeyForExisting))
                {
                    this.selected = true;
                    this.DisableAction2 = true;
                    system.debug('-----Existing Records ---'+this.record.field1__c);
                }               
            }
            
            // Assign columns 
            if(columnList.size() >= 1)
            {
                this.record.field1__c = Utils_Methods.convertToString(objFields,objFieldTypes,objects,columnList[0].getValue());
                           
                if(existingRecords!=null)
                {
                    if(existingRecords.contains(this.record.field1__c))
                    {
                        this.selected = true;
                        system.debug('-----Existing Records ---'+this.record.field1__c);
                    }
                }
                if(columnList.size()>=2)
                { 
                    this.record.field2__c = Utils_Methods.convertToString(objFields,objFieldTypes,objects,columnList[1].getValue()); 
                    if(columnList.size()>=3)
                    { 
                        this.record.field3__c = Utils_Methods.convertToString(objFields,objFieldTypes,objects,columnList[2].getValue());
                        if(columnList.size()>=4)
                        { 
                            this.record.field4__c = Utils_Methods.convertToString(objFields,objFieldTypes,objects,columnList[3].getValue());
                            if(columnList.size()>=5)
                            {                                 
                                this.record.field5__c = Utils_Methods.convertToString(objFields,objFieldTypes,objects,columnList[4].getValue());
                                if(columnList.size()>=6)
                                { 
                                    this.record.field6__c = Utils_Methods.convertToString(objFields,objFieldTypes,objects,columnList[5].getValue());
                                    if(columnList.size()>=7)
                                    { 
                                        this.record.field7__c = Utils_Methods.convertToString(objFields,objFieldTypes,objects,columnList[6].getValue());
                                        if(columnList.size()>=8)
                                        { 
                                            this.record.field8__c = Utils_Methods.convertToString(objFields,objFieldTypes,objects,columnList[7].getValue());
                                            if(columnList.size()>=9)
                                            { 
                                                this.record.field9__c = Utils_Methods.convertToString(objFields,objFieldTypes,objects,columnList[8].getValue());
                                                if(columnList.size()>=10)
                                                { 
                                                    this.record.field10__c = Utils_Methods.convertToString(objFields,objFieldTypes,objects,columnList[9].getValue()); 
                                                }
                                            }
                                        }
                                    }
                               }
                            }
                        }
                    }
                }
            }
                   
            System.Debug('****** Initializing the Properties and Variables Ends for DataDisplayWrapper******');
        }   
    } 
   
    //Getter method to display data
    public List<DataDisplayWrapper> getDisplaySearchResults()
    {
        System.Debug('****** Displaying the data Begins ******');
        System.debug('####GGA 1 - searchResults.size() : ' + searchResults.size());  
        //if(columnList[0].getValue() != '')     
        if(searchResults.size()==0)
            Init();
        
        List<DataDisplayWrapper> displayedRecords = new List<DataDisplayWrapper>();
            if(displayRecordList!=null && displayRecordList.size()>0)
            {
                for(DataDisplayWrapper dataWrapper : searchResults) 
                {
                    if(dataWrapper.pageNumber==(getpageNumber()))
                    {
                        DataTemplate__c dt = new DataTemplate__c();
                        dt  = dataWrapper.record;
                        if(dt.field8__c != ' ')
                        DisplayedRecords.add(dataWrapper);
                    }
                }
            } 
            if(DisplayedRecords.siZe() == 0)
                displayRecordList = new  List<sObject>();
        system.debug('------DisplayedRecords-----'+DisplayedRecords);
        System.Debug('****** Displaying the data Ends ******');
        return displayedRecords ;

    }
    /* Init method */
    public void Init()
    {
        System.Debug('****** Init Method Begins for VCC06_DisplaySearchResults******');
        pageNumber = 1;    
        numberOfPages = 1;
               
        // Assign Column Headers
        if(columnList!= null)
        {
            if(columnList.size()>= 1)
            {   
                columnHeader1= columnList[0].getLabel();
                if(columnList.size()>=2)
                {
                    columnHeader2= columnList[1].getLabel();
                    if(columnList.size()>=3)
                    { 
                        columnHeader3= columnList[2].getLabel();
                        if(columnList.size()>=4)
                        { 
                            columnHeader4= columnList[3].getLabel();
                            if(columnList.size()>=5)
                            {
                                columnHeader5= columnList[4].getLabel();
                                if(columnList.size()>=6)
                                { 
                                    columnHeader6= columnList[5].getLabel();
                                    if(columnList.size()>=7)
                                    { 
                                        columnHeader7= columnList[6].getLabel();
                                        if(columnList.size()>=8)
                                        { 
                                            columnHeader8= columnList[7].getLabel(); 
                                            if(columnList.size()>=9)
                                            { 
                                                columnHeader9= columnList[8].getLabel(); 
                                                if(columnList.size()>=10)
                                                { 
                                                    columnHeader10= columnList[9].getLabel();
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }  
        }   
           
        searchResults = new List<DataDisplayWrapper>();
        
        integer index=0; // Page Index
        integer pages=1; // Page number

        Schema.sObjectType objType;
        Schema.DescribeSObjectResult objDescribe;
        Map<String, Schema.SObjectField> objFields = new Map<String, Schema.SObjectField>();
        Map<String, Schema.DisplayType> objFieldTypes = new Map<String, Schema.DisplayType>();
        Schema.SObjectField field;
        Schema.DescribeFieldResult fieldDescribe;
        Schema.DisplayType fieldType;
        
        System.debug('#### COLUMN LIST: ' + columnList);
        
        if(displayRecordList!=null && displayRecordList.size()>0)
        {
            sObj = displayRecordList[0];            
            objType= sObj.getSObjectType();
            objDescribe =objType.getdescribe();
            objFields =objDescribe.fields.getMap();
            
            for(SelectOption selectValue:columnList)
            {
                field = objFields.get(selectValue.getvalue());
                
                fieldDescribe = field.getdescribe();
                fieldType = fieldDescribe.getType(); 
                objFieldTypes.put(selectValue.getvalue(),fieldType);          
            }
            
            if(FieldForKeyList != null)
            {
                for(String selectValue:FieldForKeyList)
                {
                    field = objFields.get(selectValue);
                    fieldDescribe = field.getdescribe();
                    fieldType = fieldDescribe.getType(); 
                    objFieldTypes.put(selectValue,fieldType);          
                } 
            }           
            
            system.debug('-----objFieldTypes-----'+objFieldTypes);
            for(Integer recordSize=0; recordSize<displayRecordList.size(); recordSize++)
            {
                sObj = displayRecordList[recordSize];  
                searchResults.add(new DataDisplayWrapper(sObj,index,pages,columnList,pageController,objFields,FieldForKeyList,existingRecords,objFieldTypes));
                index++;
                
                // If the page is full, go to the next one
                if(index==recordsPerPage) 
                {
                    index=0;
                    pages++;
                }
                
                if(pages > 1)
                {
                    if(math.mod(displayRecordList.size(), recordsPerPage) == 0)
                        numberOfPages = pages-1;
                    else
                        numberOfPages = pages;
                }
                else numberOfPages = 1;
            }
        }
        System.Debug('****** Init Method Ends for VCC06_DisplaySearchResults******');
    }  
    
    /* Displays the number of start & end of the record
     * in each page.
     */
    public String getrecordsDisplay()
    {
        System.Debug('****** Displaying the number of start & end of the record Begins ******');
        string results;
        if(displayRecordList.size() == 0)
        {
            results = 0+'';
        } 
        else if((getpageNumber()==numberOfPages) && displayRecordList.size()>0)
        {
            results= ' ('+((getpageNumber()-1)*recordsPerPage+1) + ' - '+ displayRecordList.size()+') ';
        }
        else if((displayRecordList.size()>recordsPerPage)&& displayRecordList.size()>0)
        {
            results= ' ('+((getpageNumber()-1)*recordsPerPage+1) + ' - '+((getpageNumber())*recordsPerPage)+') ';
        }   
        else if(displayRecordList.size()>0)
        {
            results= ' (1 - '+ displayRecordList.size() + ') ';
        }
        system.debug('------results-----'+results);
        System.Debug('****** Displaying the number of start & end of the record Ends ******');
        return results;
    }  

    /* Redirects to the first page */ 
    public void first()
    {
        System.Debug('****** Redirection to the First page Begins ******');
        if(pageNumber!=1)
            pageNumber=1;
        System.Debug('****** Redirection to the First page Ends ******');
    }
    
    /* Redirects to the last page */ 
    public void last()
    {
        System.Debug('****** Redirection to the Last page Begins ******');
        if(pageNumber!=numberOfPages)
            pageNumber=numberOfPages;
        System.Debug('****** Redirection to the Last page Ends ******');
    }  
    
    /* Redirects to the previous page */
    public void previous()
    {
        System.Debug('****** Redirection to the previous page Begins ******');
        if(pageNumber!=1)
            pageNumber--;
        System.Debug('****** Redirection to the previous page Ends ******');
    }   
    
    /* Redirects to the next page */
    public void next()
    {
        System.Debug('****** Redirection to the Next page Begins ******');
        if(pageNumber<=numberOfPages)
            pageNumber++;
        System.Debug('****** Redirection to the Next page Ends ******');
    }
    
    /* This method assigns the sorting map values to the corresponding sort column variables */
    public void assignMapValues()
    {
        system.debug('******Assigning map values Begins ******');
        col1Sort =    columnSort.get('0');        
        col2Sort =    columnSort.get('1');                                                           
        col3Sort =    columnSort.get('2');
        col4Sort =    columnSort.get('3');
        col5Sort =    columnSort.get('4');
        col6Sort =    columnSort.get('5');   
        col7Sort =    columnSort.get('6');                                                           
        col8Sort =    columnSort.get('7');
        col9Sort =    columnSort.get('8');
        col10Sort =    columnSort.get('9');
        system.debug('******Assigning map values Ends ******');        
    }
    /* Sorts the selected column.Calls the Utils_Sorter class and returns the sorted results
     *
     */
    public PageReference sortColumn() 
    {
        System.Debug('****** Sorting of selected column Begins******');

        //This check is done to bypass the sorting. If the sortingNotReqr variable is trure
        //then sorting will be skipped.
        
        if(sortingNotReqr!=true)
        {
            columnSort = new Map<String, String>();
            sortByDef = true;
            columnSort.put('0',null);
            columnSort.put('1',null);
            columnSort.put('2',null);                                        
            columnSort.put('3',null);
            columnSort.put('4',null);
            columnSort.put('5',null);
            columnSort.put('6',null);
            columnSort.put('7',null);
            columnSort.put('8',null);
            columnSort.put('9',null);
            assignMapValues();
            setSortedBy(system.currentpagereference().getparameters().get('sortColumn'));
            displayRecordList = (List<Sobject>)sorter.getSortedList(displayRecordList,columnList[Integer.ValueOf(system.currentpagereference().getparameters().get('sortColumn'))].getValue(), sortStatus);
            system.debug('----displayRecordList ---'+displayRecordList );
            Init();
        }
        System.Debug('****** Sorting of selected column Ends******');
        return null;
    }
    /* This method will be called on change of PageNumber */
    public pagereference pageNumberRenderer()
    {
        System.Debug('****** pageNumberRenderer Begins******');
        getpageNumber();
        getrecordsDisplay();
        System.Debug('****** pageNumberRenderer  Begins******');        
        return null;
    }
    /* Sets the sorting order for the selected column */
    private void setSortedBy(String value) 
    {
        System.Debug('****** Setting of sorting order for the selected column Begins ******');
        if (sortedBy == value) 
        {    
             sortStatus = !sortStatus;             
        } 
        else 
        {
            sortStatus = true;
        }
        columnSort.put(value, String.valueOf(sortStatus));
        assignMapValues();
        sortedBy = value;
        System.Debug('****** Setting of sorting order for the selected column Ends ******');
    }    
}