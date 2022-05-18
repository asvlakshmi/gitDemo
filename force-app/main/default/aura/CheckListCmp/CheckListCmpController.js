({
    
    handleLoad: function(cmp, event, helper) {
        cmp.set('v.showSpinner', false);
    },

    handleSubmit: function(cmp, event, helper) {
        cmp.set('v.disabled', true);
        cmp.set('v.showSpinner', true);
    },

    handleError: function(cmp, event, helper) {
        // errors are handled by lightning:inputField and lightning:nessages
        // so this just hides the spinnet
        cmp.set('v.showSpinner', false);
    },

    handleSuccess: function(cmp, event, helper) {
        cmp.set('v.showSpinner', false);
        var params = event.getParams();
        cmp.set('v.checkListId', params.response.id);
        cmp.set('v.saved', true);
    },
    handleTitleLoad: function(cmp, event, helper) {
        cmp.set('v.showSpinner', false);
    },
   
    doInit : function(component, event, helper) {
       
        
        helper.getcheckList(component);
        helper.getcheckHeader(component);
        
    },
    changeHeaderName : function(component, event, helper) {
        component.set('v.changeHeader', true);
    },
    saveHeader : function(component, event, helper) {
        component.set('v.changeHeader', false);
        helper.saveCheckHeader(component);
    }
   
})