public class DashboardController {
    @AuraEnabled
    public static List<Patient__c> getPatients() {
    	return [
            SELECT Full_Name__c
                 , Gender__c
            	 , Steps_Completed__c
            	 , Goal__c
                 , Height__c
       	      FROM Patient__c 
          ORDER BY createdDate ASC
        ];
    } 
    
	@AuraEnabled
    public static Patient__c findPatientById(String patientId) {
    	return [ 
            SELECT Full_Name__c
            	 , Gender__c
            	 , Height__c
       	      FROM Patient__c 
             WHERE Id = :patientId];
    }
}