$(document).ready(function() {
	$('.input-group.date').datepicker({
    format: "dd.mm.yyyy",
    todayBtn: "linked",
    language: "de",
    daysOfWeekDisabled: "0,6",
    calendarWeeks: true,
    autoclose: true,
    todayHighlight: true
	});
	//$('.input-group.date').datepicker('update', moment(get_url_param('begin_date')).format('DD.MM.YYYY'));
});	
function get_url_param(name) {
  name = name.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
 
	var regexS = "[\\?&]"+name+"=([^&#]*)";
	var regex = new RegExp( regexS );
	var results = regex.exec( window.location.href );

	if ( results == null )
	  return "";
	else
	  return results[1];
}