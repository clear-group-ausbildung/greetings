"use strict"
setInterval (->
  $("#refreshable").load location.href + " #refreshable>*", ""
  return
), 1000
