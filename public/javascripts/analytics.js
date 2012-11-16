var _gaq = _gaq || [];
_gaq.push(['_setAccount', 'UA-35613950-1']);
_gaq.push(['_setDomainName', 'hotkey-eve.com']);
_gaq.push(['_trackPageview']);

(function() {
  var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
  ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
  var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
})();

// register event when someone clicks a download link
$(function() {
  $(".download").click(function() {
    _trackEvent("EVE", "Download");
  });
});

