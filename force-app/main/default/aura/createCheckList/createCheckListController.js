({
    doInit : function(component, event, helper) {
        // Prepare the action to load checklist record
         component.set('v.columns', [
            {label: 'Checklist Name', fieldName: 'Name', type: 'text'},
            {label: 'Type', fieldName: 'Type__c', type: 'text'}
        ]);
         
        
        
        helper.getcheckList(component);
        helper.getcheckListItem(component);
    },

	create : function(component, event, helper) {
    var createRecordEvent = $A.get("e.force:createRecord");
    createRecordEvent.setParams({"entityApiName": "Checklist__c"});
    createRecordEvent.fire();
	},
    /*create : function(component, event, helper) {
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
    },*/
    createCheckLineItem : function(component, event, helper) {
    var createRecordEvent = $A.get("e.force:createRecord");
    createRecordEvent.setParams({"entityApiName": "Checklist_Item__c"});
    createRecordEvent.fire();
    },
    displyCheckLineItem : function(component, event, helper) {
    component.set('v.clicolumns', [
            {label: 'Checklistitem Name', fieldName: 'Name', type: 'text'},
            {label: 'Description', fieldName: 'Description__c', type: 'text',editable: true},
            {label: 'Status', fieldName: 'Status__c', type: 'text',editable: true}
        ]);

        helper.getcheckListItem(component);
},
    handleSave: function (cmp, event, helper) {
        var draftValues = event.getParam('draftValues');
        console.log(draftValues);
        var action = cmp.get("c.saveCLI");
        action.setParams({"items" : draftValues});
        action.setCallback(this, function(response) {
            var state = response.getState();
            $A.get('e.force:refreshView').fire();
            
        });
        $A.enqueueAction(action);
        
    },
})