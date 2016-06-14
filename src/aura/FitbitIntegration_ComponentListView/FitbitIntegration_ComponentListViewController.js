({
	doInit: function(component, event, helper) {      
    	//Fetch the expense list from the Apex controller   
    	helper.getPatientList(component);
    },
    
    refreshTable : function(component, event, helper) {      
    	helper.sysncFitBitData(component, helper);
    },
    
    toggleComponent : function(component, event) {
    	var patientId = event.getParam("patientDetailsId");
        if(patientId != "")
        	component.set("v.className", "hideDivBlock");
    },
    
    showComponent : function(component, event) {
        component.set("v.className", "showDivBlock");
    }
})