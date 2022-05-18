({
	init: function (cmp, event, helper) {
        var actions = [
           
            {label: 'Edit', name: 'edit'},
           
        ]
		cmp.set('v.columns', [
            {type: 'action', typeAttributes: { rowActions: actions } },
            {label: 'Name', fieldName: 'Name', type: 'text'},
            {label: 'Description', fieldName: 'Description__c', type: 'text'},
            {label: 'Status', fieldName: 'Status__c', type: 'text'}
			
        ]);

        helper.getcheckListItem(cmp);
        
    },
    newItem: function(cmp, event, helper) {
		cmp.set("v.checkListItemId",'');
        helper.openDialog(cmp, event, helper);
        //cmp.set('v.showSpinner', false);
        //cmp.find('checkList').set("v.value",cmp.get("v.checkListId"));
    },
     handleLoad: function(cmp, event, helper) {
        cmp.set('v.showSpinner', false);
		cmp.find('checkList').set("v.value",cmp.get("v.checkListId"));
    },

    handleSubmit: function(cmp, event, helper) {
        cmp.set('v.showSpinner', true);
    },

    handleError: function(cmp, event, helper) {
        // errors are handled by lightning:inputField and lightning:nessages
        // so this just hides the spinnet
        cmp.set('v.showSpinner', false);
    },
    handleSuccess: function(cmp, event, helper) {
        cmp.set('v.showSpinner', false);
        helper.closeEditModal(cmp, event, helper);
         helper.getcheckListItem(cmp);
    },
    closeEditModal: function(cmp, event, helper) {
        helper.closeEditModal(cmp, event, helper);
    },
    handleRowAction: function (component, event, helper) {
        var action = event.getParam('action');
        switch (action.name) {
            case 'edit':
                var row = event.getParam('row');
				var recordId = row.Id;
				component.set("v.checkListItemId",recordId);
				helper.openDialog(component, event, helper);
       		    //component.set('v.showSpinner', false);
                break;           
        }
    }
})