$(document).ready(function() {
  $('#calendar').fullCalendar({
    // put your options and callbacks here
    header: {
      left   : 'prev,next prevYear,nextYear today',
      center : 'title',
      right  : 'month,agendaWeek,agendaDay'
    },
    lang         : 'de',
    defaultView  :'month',
    weekends     : false,
    weekMode     : 'liquid',
    height       : 700,
    selectable   : true,
    minTime      : "07:00:00",
    maxTime      : "21:00:00",
    allDaySlot   : false,
    slotDuration : '00:15:00',
    weekNumbers  : true,
    events       : '/appointments.json',
    eventRender: function(event, element, view) { 
      element.qtip({ 
        style: { 
          classes : 'qtip-bootstrap' 
        }, 
        content: {
          title : moment(event.start).format('HH:mm')+' Uhr',
          text  : event.tooltip
        },
        hide: {
          fixed : true,
          delay : 300
        },
        position: {
          my : 'top center',
          at : 'bottom center'
        },
        show: {
          effect: function() {
            $(this).slideDown();
          }
        },
        hide: {
          effect: function() {
            $(this).slideUp();
          }
        }
      });
    },
    dayClick: function(date, jsEvent, view) {
      document.location.href = "/appointments/new?begin_date=" + date.format();
    }
  });
});
