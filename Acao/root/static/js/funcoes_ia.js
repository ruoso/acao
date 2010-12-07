jQuery(document).ready(function() {
	//Format dateTimes with class longDateFormat
	formatDateTimeBySelectClass(".longDateFormat");

	$(".collapsible").collapse();

	$("fieldset.collapsibleClosed").collapse( { closed : true } );

});




