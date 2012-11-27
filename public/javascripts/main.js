$(function() {
  $(".shortcut a").click(function(event) {
    event.preventDefault();

    console.debug($(this).siblings("table"));
    $(this).colorbox({
      inline: true,
      href:   $(this).siblings("table")
    });
  });
});

