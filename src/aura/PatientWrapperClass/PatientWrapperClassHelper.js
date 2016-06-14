({
	getPatientList : function(component) {
		var action = component.get("c.getPatients");

        //Set up the callback
        //var self = this;
        action.setCallback(this, function(actionResult) {
            console.log('actionResult.getReturnValue() => ',actionResult.getReturnValue());
            component.set("v.patients", actionResult.getReturnValue()); 
        });
        $A.enqueueAction(action);
	},
    
    sysncFitBitData : function(component, helper) {
		var dataSyncAction = component.get("c.sysncFitBitData");
        dataSyncAction.setCallback(this, function(actionResult) {
            console.log("Updated Patient : "+actionResult.getReturnValue());
        	//helper.getPatientList(component);
        	component.set("v.patients", actionResult.getReturnValue());
        });
        $A.enqueueAction(dataSyncAction);
	}
})