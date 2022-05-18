({
	getcheckListItem : function(component) {
        var action = component.get("c.getcheckListItem");
        action.setCallback(this, function(data){
            var state = data.getState();
            if (state === "SUCCESS") {
            	component.set("v.data", data.getReturnValue());
            }else if (state == "Error"){
                alert('Unknown Error');
            }
       });
        $A.enqueueAction(action);
	},
    closeEditModal: function(component, event, helper) {
        
        var cmpTarget = component.find('editDialog');
        var cmpBack = component.find('dialogBack');
        $A.util.removeClass(cmpTarget, 'slds-fade-in-open');
        $A.util.removeClass(cmpBack, 'slds-backdrop--open'); 
     
    },
	openDialog : function(component, event, helper) {
		var cmpTarget = component.find('editDialog');
        var cmpBack = component.find('dialogBack');
        $A.util.addClass(cmpTarget, 'slds-fade-in-open');
        $A.util.addClass(cmpBack, 'slds-backdrop--open'); 
	}
})