setInterval( function() {
  $("#refreshable").load(location.href+" #refreshable>*", "");
}, 1000);
