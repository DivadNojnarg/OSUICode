$(function() {
  $(".play").click(function() {
    updateJog();
    if ($(".jog").hasClass("paused")) {
      $(this).addClass("blink-green");
    } else {
      $(this).removeClass("blink-green");
    }
  });

  $("body").keyup(function(e) {
    if (e.keyCode == 32) updateJog();
  });

});

function updateJog() {
  if ($(".jog").hasClass("paused")) {
    $(".jog").removeClass("paused");
    $(".jog").addClass("running");
    //song1.play();
  } else {
    $(".jog").removeClass("running");
    $(".jog").addClass("paused");
    //song1.pause();
  }
}

var song1 = new Audio('../music/track1.mp3');
