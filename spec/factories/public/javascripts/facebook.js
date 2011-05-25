jQuery(function($) {
  function login_via_facebook_into(url) {
    FB.login(function(response) {
      if (response.session)
        window.location = url;
    });
  }

  $(".login-via-facebook-button").click(function() {
    login_via_facebook_into($(this).attr("rel"));
    return false;
  });

  if ($(".login-via-facebook-button").size() > 0) {
    $("<script></script>").attr('async', true).attr('src', document.location.protocol + '//connect.facebook.net/en_US/all.js').appendTo('#fb-root');
  }

  window.fbAsyncInit = function() {
    FB.init({ appId: $("#fb-root").attr("data-api-key"), status: true, cookie: true, xfbml: true });
  };
});
