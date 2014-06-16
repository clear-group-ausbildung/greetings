$(document).ready(function() {
    $('#calendar').fullCalendar({
        // put your options and callbacks here
        header: {
            left: 'prev,next prevYear,nextYear today',
            center: 'title',
            right: 'month,agendaWeek,agendaDay'
        },
        lang: 'de',
        defaultView :'month',
        weekends: false,
        weekMode: 'liquid',
        height: 700,
        selectable: true,
        minTime : "07:00:00",
        maxTime: "21:00:00",
        allDaySlot: false,
        slotDuration: '00:15:00',
        weekNumbers: true,
        events: '/appointments.json',
        eventRender: function(event, element) {
            element.attr('title', event.tooltip);
        }
    });
});
