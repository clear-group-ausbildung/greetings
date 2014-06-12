$(document).ready(function() {
    $('#calendar').fullCalendar({
        // put your options and callbacks here
        lang: 'de',
        header: {
            left: 'prev,next prevYear,nextYear today',
            center: 'title',
            right: 'month,agendaWeek,agendaDay,'
        },
        defaultView: 'month',
        weekends: false,
        weekMode: 'liquid',
        height: 700,
        selectable: true,
        minTime : "07:00:00",
        maxTime: "21:00:00",
        allDaySlot: false,
        slotDuration: '00:15:00',
        weekNumbers: true,
        events: [
            {
                title: 'Test Termin 1',
                start: '2014-06-02T07:15:00',
                end: '2014-06-02T09:45:00',
                tooltip: 'Tooltip Termin 1'
            },
            {
                title: 'Test Termin 2',
                start: '2014-06-10T08:00:00',
                end: '2014-06-10T19:30:00',
                tooltip: 'Tooltip Termin 2'
            },
            {
                title: 'Test Termin 3',
                start: '2014-06-12T14:30:00',
                end: '2014-06-12T18:30:00',
                tooltip: 'Tooltip Termin 3'
            }
        ],
        eventRender: function(event, element) {
            element.attr('title', event.tooltip);
        },
        dayClick: function(date, jsEvent, view) {
            alert('Tage geklickt: ' + date.format());
        }
    })
});