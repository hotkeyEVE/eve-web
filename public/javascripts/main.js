$(function() {
  $(".full-history .toggle").click(function() {
    $(this).hide();
    $(".older-versions").show();
  });

  $(".app-shortcuts a").click(function(event) {
    event.preventDefault();

    $(".app-shortcuts table").hide();
    $(".app-shortcuts").removeClass("active");

    $(this).siblings("table").show();
    $(this).parent().addClass("active");
    $(this).parent().ScrollTo();
  });
});

