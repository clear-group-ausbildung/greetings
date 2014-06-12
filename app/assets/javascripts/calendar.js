$(document).ready(function() {
    $('#calendar').fullCalendar({
            // put your options and callbacks here
            lang: 'de',
            header: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'month,agendaWeek,agendaDay'
            },
            defaultView: 'month',
            weekends: false,
            weekMode: 'liquid',
            height: 700,
            events: [
                    {
                            title: 'Test Termin 1',
                            start: '2014-06-01'
                    },
                    {
                            title: 'Test Termin 2',
                            start: '2014-06-10',
                            end: '2014-06-10'
                    },
                    {
                            title: 'Test Termin 3',
                            start: '2014-06-12T14:30:00',
                            end: '2014-06-12T18:30:00'
                    }
            ]
    })
    });