({
	doSave : function(component, event, helper) {
        var action = component.get("c.createChecklist");
        action.setCallback(this, function(data){
            var state = data.getState();
            if (state === "SUCCESS") {
            	component.set("v.checklistobjid", data.getReturnValue());
            }else if (state == "Error"){
                alert('Unknown Error');
			}
		});
        
        $A.enqueueAction(action);
    },
    showCheckLists : function(component, event, helper){
        
        var action = component.get("c.retrieveChecklist");
        action.setCallback(this, function(data){
            var state = data.getState();
            if (state === "SUCCESS") {
            	component.set("v.checklistrecords", data.getReturnValue());
            }else if (state == "Error"){
                alert('Unknown Error');
			}
		});
        
        $A.enqueueAction(action);
    }
})