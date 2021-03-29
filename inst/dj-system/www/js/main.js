$(function() {
  $(".play").click(function() {
    if ($(".jog").hasClass("paused")) {
      $(".jog").removeClass("paused");
      $(".jog").addClass("running");
      //song1.play();
    } else {
      $(".jog").removeClass("running");
      $(".jog").addClass("paused");
      //song1.pause();
    }
  });
});

var song1 = new Audio('../music/track1.mp3');
