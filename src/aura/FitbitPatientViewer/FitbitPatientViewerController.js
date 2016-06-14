({
	navigateToPatient:function(component){
    	var patient = component.get("v.patient");
        console.log('patient navigateToPatient => ',patient);
    	
        //for application type event
        $A.get("e.c:FitbitGetPatientDetails").setParams({
	    	patientDetailsId : patient.patient_Id 
	    }).fire();
	}
})