({  
    toggleField: function(component, selectedValue) {
        
        /*
         * 
         *  Instructions to handle field appearance and dependencies
		 *
         * 
         * */
        var fieldCommon = component.find("fieldCommon").getElement().querySelector('input');
        var descriptionProject = component.find("descriptionProject").getElement().querySelector('textarea');
        var lienLinkedin = component.find("lienLinkedin");
        var descriptionAccompagnement = component.find("descriptionAccompagnement");
        var mesExpertisesField = component.find("MesExpertises");
        var accompagnementMentor = component.find("accompagnementMentor");
        
        
        $A.util.addClass(fieldCommon.parentNode, 'hidden'); 
        fieldCommon.removeAttribute('required');
        $A.util.addClass(descriptionProject.parentNode,'hidden');
        descriptionProject.removeAttribute('required');
        $A.util.addClass(lienLinkedin,'hidden');
        $A.util.addClass(descriptionAccompagnement,'hidden');
        $A.util.addClass(accompagnementMentor,'hidden');
        //$A.util.addClass(accompagnementMentor,'flex-div');
        $A.util.addClass(mesExpertisesField, 'hidden');
        
        
        if (selectedValue === "Porteur de projet" || selectedValue === "Startup" || 
            selectedValue === "Entreprise digitale" || selectedValue === "Diaspora") {
            $A.util.removeClass(fieldCommon.parentNode, 'hidden');
            fieldCommon.setAttribute('required', 'true');
            $A.util.removeClass(descriptionProject.parentNode,'hidden');
            descriptionProject.setAttribute('required', 'true');
        }else if(selectedValue === "Expert" ){
            $A.util.removeClass(lienLinkedin,'hidden');
            $A.util.removeClass(mesExpertisesField, 'hidden');
            $A.util.removeClass(accompagnementMentor,'hidden');
           // $A.util.removeClass(accompagnementMentor,'flex-div');
        }else if(selectedValue === "Mentor"){
            $A.util.removeClass(descriptionAccompagnement,'hidden');
            $A.util.removeClass(lienLinkedin,'hidden');
        }
    },

   
})