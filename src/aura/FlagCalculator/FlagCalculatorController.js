({
	doInit : function(component, event, helper) {
	  
      component.set("v.redImageClass", "hideDivBlock");
      component.set("v.yellowImageClass", "hideDivBlock");
      component.set("v.greenImageClass", "hideDivBlock");

      var goal = component.get("v.goal");
      var steps = component.get("v.steps");

          if(steps < goal*0.5) {
              component.set("v.redImageClass", "displayDivBlock");
              component.set("v.yellowImageClass", "hideDivBlock");
      		  component.set("v.greenImageClass", "hideDivBlock");
          } else if(steps === goal){
              component.set("v.greenImageClass", "displayDivBlock");  
              component.set("v.redImageClass", "hideDivBlock");
              component.set("v.yellowImageClass", "hideDivBlock");
          } else {
              component.set("v.yellowImageClass", "displayDivBlock");
              component.set("v.redImageClass", "hideDivBlock");
      	      component.set("v.greenImageClass", "hideDivBlock");
          }
	}
})