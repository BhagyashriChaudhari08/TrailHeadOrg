({
    doInit:function(component, event, helper) {
        component.set("v.className", "hideDivBlock");                          
    },
    
    populatedetail : function(component, event, helper) {
        var patientId = event.getParam("patientDetailsId");
        if (patientId == "") {
            component.set("v.className", "hideDivBlock");
        } else {
        	var action = component.get("c.getPatientsById");
        	action.setParams({
           		"patientId": patientId
        	});
        	action.setCallback(this, function(a) {
            	component.set("v.className", "displayDivBlock");
            	component.set("v.patient", a.getReturnValue());
        	});
        	$A.enqueueAction(action);
        }
    },
    
    navigateToDashboard : function(component, event, helper) {
    	component.set("v.className", "hideDivBlock");
        $A.get("e.c:FitbitIntegration_NavigateToDashboard").fire();
    }
    /*locationChange : function(component, event, helper) {
        var token = event.getParam('token');
        console.log('token => ',token);
        
       
        if(token != null){
            if (token.indexOf('patient/') === 0) {
              	//var mainDiv = component.find('mainDivBlock');
                component.set("v.className", "displayDivBlock");
            	var patientId = token.substr(token.indexOf('/') + 1);
            	
            	var action = component.get("c.getPatientsById");
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
	},*/
})