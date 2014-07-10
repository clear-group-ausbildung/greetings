$(document).ready(function() {
  $('.input-group.date').datepicker({
    format             : "dd.mm.yyyy",
    todayBtn           : "linked",
    language           : "de",
    daysOfWeekDisabled : "0,6",
    calendarWeeks      : true,
    autoclose          : true,
    todayHighlight     : true
  });
}); 

function get_url_param(name) {
  name = name.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
  
  var regexS  = "[\\?&]"+name+"=([^&#]*)";
  var regex   = new RegExp( regexS );
  var results = regex.exec( window.location.href );

  if (results == null) {
   return "";
  } else {
   return results[1];
  }
}
