({
	getcheckList : function(component) {
		alert('hi');
        var action = component.get("c.getcheckList");
        //action.setParams({"v.chlID": component.get("v.checklist[0].Id")});
        //alert('v.chlID::::'+v.chlID);
        //debugger;
        action.setCallback(this, function(data){
            var state = data.getState();
            if (state === "SUCCESS") {
            	component.set("v.checklist", data.getReturnValue());
               
            }else if (state == "Error"){
                alert('Unknown Error');
            }
       });
        $A.enqueueAction(action);
	},
    getcheckListItem : function(component) {
        alert('hello one');
        var action = component.get("c.getcheckListItem");
        
		alert('hello');
        //debugger;
        action.setCallback(this, function(data){
            var state = data.getState();
            if (state === "SUCCESS") {
            	component.set("v.checklistitem", data.getReturnValue());
            }else if (state == "Error"){
                alert('Unknown Error');
            }
       });
        $A.enqueueAction(action);
	},
})