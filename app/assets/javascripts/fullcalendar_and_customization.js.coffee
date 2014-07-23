"use strict"
$(document).ready ->
  $("#calendar").fullCalendar
    
    header:
      left: "prev,next prevYear,nextYear today"
      center: "title"
      right: "month,agendaWeek,agendaDay"

    lang: "de"
    defaultView: "month"
    weekends: false
    weekMode: "liquid"
    height: 700
    selectable: true
    minTime: "07:00:00"
    maxTime: "21:00:00"
    allDaySlot: false
    slotDuration: "00:15:00"
    weekNumbers: true
    events: "/appointments.json"
    eventRender: (event, element) ->
      element.qtip
        style:
          classes: "qtip-bootstrap"

        content:
          title: moment(event.start).format("HH:mm") + " Uhr"
          text: event.tooltip

        hide:
          fixed: true
          delay: 300
          effect: ->
            $(this).slideUp()
            return

        position:
          my: "top center"
          at: "bottom center"

        show:
          effect: ->
            $(this).slideDown()
            return

      return

    dayClick: (date) ->
      document.location.href = "/appointments/new?begin_date=" + date.format()
      return

  return
