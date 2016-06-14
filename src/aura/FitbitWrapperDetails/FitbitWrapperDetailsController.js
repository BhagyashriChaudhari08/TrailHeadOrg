({
    doInit:function(component, event, helper) {
        //var mainDiv = component.find('mainDivBlock');
        //console.log('jjjjj',mainDiv);
        //mainDiv.set("v.class", "hideDivBlock");
        
        component.set("v.className", "hideDivBlock");                           
    },
    locationChange : function(component, event, helper) {
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
	},
    /*populatedetail : function(component, event, helper) {
        var patientId = event.getParam("patientDetailsId");
        console.log('patientId => ',patientId);
        var action = component.get("c.getPatientsById");
        action.setParams({
           	"patientId": patientId
        });
        action.setCallback(this, function(a) {
            console.log('a.getReturnValue() => ',a.getReturnValue());
            component.set("v.patient", a.getReturnValue());
        });
        $A.enqueueAction(action);
    }*/
    
})