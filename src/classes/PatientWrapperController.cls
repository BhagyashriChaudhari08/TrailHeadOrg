public class PatientWrapperController {    
    @AuraEnabled
    public static List<PatientWrapper> getPatients() {
        List<PatientWrapper> wcList = new List<PatientWrapper>();
        List<Patient__c> patientList = [
            SELECT Full_Name__c
                 , Gender__c
            	 , Steps_Completed__c
            	 , Goal__c
                 , Height__c
            	 , Id
            	 , Patient_Id__c
            	 , Heart_Rate__c
                 , Weight__c
       	      FROM Patient__c
          ORDER BY createdDate ASC
        ];
        if(patientList.size() > 0){
            for(Patient__c patient : patientList){
                PatientWrapper wc = new PatientWrapper();
                wc.id = patient.Id;
                wc.name = patient.Full_Name__c;
                wc.steps = patient.Steps_Completed__c;
                wc.goal = patient.Goal__c;
                wc.heartRate = patient.Heart_Rate__c;
                wc.height = patient.Height__c;
                wc.weight = patient.Weight__c;
                wc.patient_Id = patient.Patient_Id__c;
                wcList.add(wc); 
            }
        }
        return wcList;
    }
    
    @AuraEnabled
    public static PatientWrapper getPatientsById(String patientId) {
        //list<Patient__c> patientList = getWrapperList();
        String query = 'SELECT Patient_Id__c, Full_Name__c, Gender__c, Steps_Completed__c, Goal__c, Height__c, Heart_Rate__c, Weight__c FROM Patient__c where Patient_Id__c = :patientId ORDER BY createdDate ASC';
        List<Patient__c> patientList = Database.query(query);
        PatientWrapper wrapperObj;       
        system.debug('patientList => '+patientList);
        for (Patient__c patient : patientList) {
            wrapperObj = new PatientWrapper();
            //if (patientId == patient.Patient_Id__c) {
                wrapperObj.id = patient.Id;
                wrapperObj.name = patient.Full_Name__c;
                wrapperObj.steps = patient.Steps_Completed__c;
                wrapperObj.goal = patient.Goal__c;
                wrapperObj.heartRate = patient.Heart_Rate__c;
                wrapperObj.height = patient.Height__c;
                wrapperObj.weight = patient.Weight__c;
                wrapperObj.patient_Id = patient.Patient_Id__c;
            	//break;
            //}
        }
        system.debug('wrapperObj => '+wrapperObj);
        return wrapperObj;
    }
    
    /*public static List<Patient__c> getWrapperList() {
        String jsonstring = '['+
   						+'{"Id":"a012800000SBlH7AAL", "Full_Name__c":"Pallavi", "Steps_Completed__c":"2000", "Goal__c":"5000", "Heart_Rate__c":"72", "Height__c":"5.4","Weight__c":"50.0"},'
      					+'{"Id":"a012800000SBlH8AAL", "Full_Name__c":"Bhagyashri", "Steps_Completed__c":"10000", "Goal__c":"10000", "Heart_Rate__c":"85", "Height__c":"5.4","Weight__c":"10.0"},'
      					+'{"Id":"a012800000SBlH9AAL", "Full_Name__c":"Purushottam", "Steps_Completed__c":"6000", "Goal__c":"8000", "Heart_Rate__c":"72","Height__c":"5.3","Weight__c":"60"}'
   						+']';
            			
        list<Patient__c> patientList = (list<Patient__c>)JSON.deserialize(jsonstring, list<Patient__c>.class);
        return patientList;
    }*/
    
    @AuraEnabled
    public static List<PatientWrapper> sysncFitBitData(){
        
        String query = 'SELECT Patient_Id__c, Full_Name__c, Gender__c, Steps_Completed__c, Goal__c, Height__c FROM Patient__c where Patient_Id__c = \'4LR2VZ\' ORDER BY createdDate ASC';
        //String query = 'SELECT Patient_Id__c, Full_Name__c, Gender__c, Steps_Completed__c, Goal__c, Height__c FROM Patient__c ORDER BY createdDate ASC';
        List<Patient__c> patientList = Database.query(query);
        String todaysDate =String.valueOf(System.today());
        todaysDate = todaysDate.replace(' 00:00:00', '');
        List<Patient__c> patientListToUpdate = new List<Patient__c>();
        for(Patient__c patient :patientList){
            Integer stepsCompleted = 0;
            String url = FitForceUtility.ACTIVITY_API.replace('TODAY', todaysDate);
            String activityJson = FitForceUtility.doHTTPCallout(FitForceUtility.GET, url);
            ActivityWrapper activityWrapper = (ActivityWrapper) JSON.deserialize(activityJson, Type.forName('ActivityWrapper'));
            System.debug('activityWrapper :'+activityWrapper);
            for(ActivityWrapper.Activities act :activityWrapper.activities){
                System.debug('Steps :'+act.steps);
                if(act.steps != NULL){
                    patient.Steps_Completed__c = Integer.valueOf(act.steps);
                    patientListToUpdate.add(patient);
                }
            }
        }
        Database.update(patientListToUpdate);
        system.debug('Updated List :'+patientListToUpdate);
        //return patientListToUpdate.size();
        
        List<PatientWrapper> wcList = new List<PatientWrapper>();
        if(patientListToUpdate.size() > 0){
            for(Patient__c patient : patientListToUpdate){
                PatientWrapper wc = new PatientWrapper();
                wc.id = patient.Id;
                wc.name = patient.Full_Name__c;
                wc.steps = patient.Steps_Completed__c;
                wc.goal = patient.Goal__c;
                wc.heartRate = patient.Heart_Rate__c;
                wc.height = patient.Height__c;
                wc.weight = patient.Weight__c;
                wc.patient_Id = patient.Patient_Id__c;
                wcList.add(wc); 
            }
        }
         
        return wcList;
    } 
}