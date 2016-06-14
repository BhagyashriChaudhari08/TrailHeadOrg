({
   //Fetch the accounts from the Apex controller
  getPatientList: function(component) {
    var action = component.get("c.getPatients");

    //Set up the callback
    var self = this;
    action.setCallback(this, function(actionResult) {
        component.set("v.patients", actionResult.getReturnValue()); 
    });
    $A.enqueueAction(action);
  }   
})