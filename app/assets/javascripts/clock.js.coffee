"use strict"
(($) ->
  $.fn.simpleClock = ->

    getTime = ->
      date = new Date()
      hour = date.getHours()
      day: weekdays[date.getDay()]
      date: date.getDate()
      month: months[date.getMonth()]
      hour: appendZero(hour)
      minute: appendZero(date.getMinutes())
      second: appendZero(date.getSeconds())

    appendZero = (num) ->
      return "0" + num  if num < 10
      num

    refreshTime = ->
      now = getTime()
      $("#date").html now.day + ", " + now.date + ". " + now.month
      $("#time").html now.hour + ":" + now.minute + ":" + now.second + " Uhr"
      return

    weekdays = [
      "Sonntag"
      "Montag"
      "Dienstag"
      "Mittwoch"
      "Donnerstag"
      "Freitag"
      "Samstag"
    ]

    months = [
      "Januar"
      "Februar"
      "März"
      "April"
      "Mai"
      "Juni"
      "Juli"
      "August"
      "September"
      "Oktober"
      "November"
      "Dezember"
    ]

    refreshTime()
    setInterval refreshTime, 1000
    return

  return
) jQuery
$(document).ready ->
  $("#clock").simpleClock()
  return
