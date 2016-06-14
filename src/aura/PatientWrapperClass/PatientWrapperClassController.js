({
	doInit: function(component, event, helper) {      
    	//Fetch the expense list from the Apex controller   
    	helper.getPatientList(component);
        console.log('component component %%=> ',component.get("v.body"));
    },
    
    refreshTable : function(component, event, helper) {      
    	//component.set("v.className", "hideDivBlock");  
        //var token1 = event.getParam('token');
        //console.log('ttt',token1);
        //component.set("v.patient", "");
        //$A.get('e.force:refreshView').fire();
        helper.sysncFitBitData(component, helper);
        
    },
  
    locationChange : function(component, event, helper) { 
        var token = event.getParam('token');
        console.log('token$$$ => ',token);	
        if(token != null){
            if (token.indexOf('patient/') === 0) {
            	var patientId = token.substr(token.indexOf('/') + 1);
            	//var patientId = component.get("v.patientId");
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
    },
    
    /*sendPatientId : function(component, event, helper) { 
    	var patientEvent = component.getEvent("patientDetailsEvent");
        console.log('patientEvent in event => ',patientEvent);
        console.log('event.source => ',event.source);
        var patientId = event.source.get("v.id");
        console.log('patient Id in event => ',patientId);
        //var patientEvent = $A.get("e.force:patientDetailsEvent");
    	patientEvent .setParams({
    		"patientDetailsId": patientId
  		});
  		patientEvent.fire();
    }*/
})