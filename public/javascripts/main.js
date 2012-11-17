$(function() {
  $(".full-history .toggle").click(function() {
    $(this).hide();
    $(".older-versions").show();
  });

  $(".shortcut a").click(function(event) {
    event.preventDefault();

    console.debug($(this).siblings("table"));
    $(this).colorbox({
      inline: true,
      href:   $(this).siblings("table")
    });
  });
});

