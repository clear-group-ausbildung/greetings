"use strict"
FADE = 2000
WS_DELAY = 60000
PIC_DELAY = 20000

pictures_data = []
pictures_counter = 0

initPictures = ->
  addToPictures(JSON.stringify($('#pictures').data('pictures')))
  return

addToPictures = (element) ->
  raw_data = JSON.parse element
  pictures_data = (raw_element for raw_element in raw_data)
  return

getPicture = ->
  result = ""
  if pictures_data.length > pictures_counter
    result = pictures_data[pictures_counter]
  else
    result = pictures_data[0]
  if pictures_data.length > pictures_counter + 1
    pictures_counter++
  else
    pictures_counter = 0
  return result

runAnimation = ->
  $('#showcase').delay(WS_DELAY).fadeOut(FADE, ->
    aPicture = getPicture()
    $('#picture').attr("src", aPicture)
    $('#pictures').fadeIn(FADE, ->
      $('#pictures').delay(PIC_DELAY).fadeOut(FADE, ->
        $('#showcase').fadeIn(FADE, ->
          runAnimation()
          return
        )
        return
      )
      return
    )
    return
  )
  return

$ ->
  initPictures()
  runAnimation() if pictures_data.length > 0