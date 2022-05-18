({
	callServer : function(component, method, callback, params) {
		 var action = component.get(method);
        if(params)
        {
            action.setParams(params);
        }
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
            	callback.call(this, response.getReturnValue());
            }else if (state == "Error"){
            	var errors = response.getError();
                if(errors){
                    console.log("Errors",errors);
                    if(errors[0] && errors[0].message){
                        throw new Error("Errors"+errors[0].message);
                    }
                }else
                {
                    throw new Error("unknown Error");
                }
                alert('Unknown Error');
            }
        });
        $A.enqueueAction(action);
	}
})