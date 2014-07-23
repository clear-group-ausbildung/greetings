"use strict"
$(document).ready ->
  $(".input-group.date").datepicker
    format             : "dd.mm.yyyy"
    todayBtn           : "linked"
    language           : "de"
    daysOfWeekDisabled : "0,6"
    calendarWeeks      : true
    autoclose          : true
    todayHighlight     : true

  return
