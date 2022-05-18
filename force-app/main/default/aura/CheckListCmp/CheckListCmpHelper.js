({
	getcheckList : function(component) {
		var action = component.get("c.getcheckList");
        //action.setParams({"v.chlID": component.get("v.checklist[0].Id")});
        //alert('v.chlID::::'+v.chlID);
        //debugger;
        action.setCallback(this, function(data){
            var state = data.getState();
            if (state === "SUCCESS") {
            	//component.set("v.checklist", data.getReturnValue());
                debugger;
                if(data.getReturnValue()!=null && !$A.util.isEmpty(data.getReturnValue())){
                    console.log('test'+data.getReturnValue());
                    component.set('v.checkListId', data.getReturnValue()[0].Id);
                    component.set('v.saved', true);
                }
                
                    component.set('v.showSpinner', false);
                //
        		
            }else if (state == "Error"){
                alert('Unknown Error');
            }
       });
        $A.enqueueAction(action);
	},
    getcheckHeader : function(component) {
		var action = component.get("c.getCheckListHierarchy");
        //action.setParams({"v.chlID": component.get("v.checklist[0].Id")});
        //alert('v.chlID::::'+v.chlID);
        //debugger;
        action.setCallback(this, function(data){
            var state = data.getState();
            if (state === "SUCCESS") {
            	//component.set("v.checklist", data.getReturnValue());
                debugger;
                if(data.getReturnValue()!=null){
                    console.log('test'+data.getReturnValue());
                    component.set('v.checkListHeader', data.getReturnValue());
                    
                }
                //
        		
            }else if (state == "Error"){
                alert('Unknown Error');
            }
       });
        $A.enqueueAction(action);
	},
    saveCheckHeader : function(component) {
		var action = component.get("c.updateCheckListHierarchy");
        action.setParams({"checkListHeader": component.get("v.checkListHeader")});
        action.setCallback(this, function(data){
            debugger;
            var state = data.getState();
            if (state === "SUCCESS") {
            	if(data.getReturnValue()!=null){
                    console.log('test'+data.getReturnValue());
               }
              
            }else if (state == "Error"){
                alert('Unknown Error');
            }
       });
        $A.enqueueAction(action);
	}
    
})