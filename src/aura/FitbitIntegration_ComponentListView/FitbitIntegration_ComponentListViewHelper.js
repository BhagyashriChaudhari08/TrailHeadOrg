({
	getPatientList : function(component) {
		var action = component.get("c.getPatients");
		action.setCallback(this, function(actionResult) {
            component.set("v.patients", actionResult.getReturnValue()); 
        });
        $A.enqueueAction(action);
	},
    
    sysncFitBitData : function(component, helper) {
        var dataSyncAction = component.get("c.sysncFitBitData");
        dataSyncAction.setCallback(this, function(actionResult) {
            component.set("v.patients", actionResult.getReturnValue());
        });
        $A.enqueueAction(dataSyncAction);
        
        $A.get("e.c:FitbitGetPatientDetails").setParams({
	    	patientDetailsId : ""
	    }).fire();
	}
})