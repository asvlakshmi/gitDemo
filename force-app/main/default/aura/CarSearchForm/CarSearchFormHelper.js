({
	handleonSearchClick : function(component, event, helper) {
		alert('Search Button was Clicked');
	},
        getCarType : function (component, helper) {
        
        /*var action = component.get("c.getCarTypes");	
        action.setCallback(this, function(data){
            var state = data.getState();
            if (state === "SUCCESS") {
            	component.set("v.carTypes", data.getReturnValue());
            }else if (state == "Error"){
                alert('Unknown Error');
            }
        });
        
        $A.enqueueAction(action);*/
            helper.callServer(component,"c.getCarTypes",function(response){
                              component.set("v.carTypes", response);
            				  });
    }
})