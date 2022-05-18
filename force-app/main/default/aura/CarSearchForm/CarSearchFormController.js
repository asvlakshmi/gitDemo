({
    doInit :function(component, event, helper){
        
        var createCarRecords = $A.get("e.force:createRecord");
        if(createCarRecords){
            component.set("v.showNew",true);
        }else{
            component.set("v.showNew",false);
            console.log('Event is not supported');
        }
        helper.getCarType(component, helper);
    },
	onSearchClick : function(component, event, helper) {
        var searchFormSubmt = component.getEvent("searchFormSubmt");
        searchFormSubmt.setParams({"carTypeId" : component.find("carTypeList").get("v.value")});
        searchFormSubmt.fire();
       // helper.handleonSearchClick(component, event, helper);
	},
    
    newValueSelected : function(component, event, helper) {
        var carTypeId = component.find("carTypeList").get("v.value");
        alert(carTypeId+'Option selected');
    },
    createRecord : function(component, event, helper){
          var createCarRecord = $A.get("e.force:createRecord"); 
        
        createCarRecord.setParams({"entityApiName" :"Car_Type__c"});
        createCarRecord.fire();
    }
    
})