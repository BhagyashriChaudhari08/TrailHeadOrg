<aura:application controller="PatientWrapperController" implements="forceCommunity:availableForAllPageTypes">
    <link href='https://eternusrnd-dev-ed--c.ap2.visual.force.com/resource/Bootstrap/' rel="stylesheet"/>
		
    
    <div class="slds" style="margin-top:10px;margin-left:10px;">
        <c:FitbitIntegration_ComponentListView />
    </div>
    <div>
      <c:FitbitIntegration_ComponentDetail />
    </div>
    
</aura:application>