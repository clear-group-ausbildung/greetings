$(function() {
  $("#animatable").click(function() {
    animate(".boxxy", 'zoomInUp');
    return false;
  });
});

function animate(element_ID, animation) {
  $(element_ID).addClass(animation);
  var wait = window.setTimeout( function(){
    $(element_ID).removeClass(animation)}, 2000
    );
}