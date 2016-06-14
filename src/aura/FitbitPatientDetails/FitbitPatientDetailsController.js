({
	locationChange : function(component, event, helper) {
        var token = event.getParam('token');
        
        console.log('token => ',token);
        if(token != null){
            if (token.indexOf('patient/') === 0) {
            	var patientId = token.substr(token.indexOf('/') + 1);
            	//var patientId = component.get("v.patientId");
            	var action = component.get("c.findPatientById");
                action.setParams({
                	"patientId": patientId
                });
                action.setCallback(this, function(a) {
                    console.log('a.getReturnValue() => ',a.getReturnValue());
                    component.set("v.patient", a.getReturnValue());
                });
            	$A.enqueueAction(action);
        	}
    	}
	}
})