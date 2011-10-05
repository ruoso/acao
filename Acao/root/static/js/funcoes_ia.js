jQuery(document).ready(function() {
	//Format dateTimes with class longDateFormat
	formatDateTimeBySelectClass(".longDateFormat");

	//Cria accordions (usando Id)
	$( "#accordion" ).accordion({ 
			    collapsible: true, 
			    autoHeight: false, 
			    active: false 
	});

	$("input,select").bind("keypress", function(e) {
		if (e.keyCode == 13) {
        	        return false;
		}
        });
	//Jquery: FieldSet com collapsed
	//$(".collapsible").collapse();
	//$("fieldset.collapsibleClosed").collapse( { closed : true } );

});
