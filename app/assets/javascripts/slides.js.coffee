"use strict"
$(document).ready ->
  $container = $("#slides").masonry()
  $container.imagesLoaded ->
    $container.masonry
      columnWidth: 200
      itemSelector: "slides.slide"
    return
  return
