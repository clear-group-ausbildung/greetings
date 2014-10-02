runSlide = ->
  $("#showcase").delay(constWsDelay).fadeOut constFade, ->
    aPicture = getPic()
    $("#picture").attr "src", aPicture
    $("#pictures").fadeIn constFade, ->
      $("#pictures").delay(constPicDelay).fadeOut constFade, ->
        $("#showcase").fadeIn constFade, ->
          runSlide()
          return
        return
      return
    return
  return
count = 0
getPic = ->
  aPicture = ""
  picsLength = thePictures.length
  if count is 0
    aPicture = thePictures[0]
  else if picsLength > count
    aPicture = thePictures[count]
  else
    aPicture = thePictures[0]
  if picsLength > count + 1
    count++
  else
    count = 0
  aPicture
"use strict"
constFade = 2000
constWsDelay = 5000
constPicDelay = 5000
thePictures = []

$(document).ready ->
  runSlide()  if thePictures.length > 0
  return

$.fn.delay = (time) ->
  @queue "fx", ->
    self = this
    setTimeout (->
      $.dequeue self
      return
    ), time
    return
