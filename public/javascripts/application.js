(function() {
  $(document).ready(function() {
    var getSignupProps, invite_code, mask_email, summary_freq_selector, togglePaypalInviteSignup, user_email;
    togglePaypalInviteSignup = function() {
      return $('.basement .paypal, .basement .invite, #invite_code_input').toggle();
    };
    $('#use_invite, #use_paypal').click(function(e) {
      e.preventDefault();
      return togglePaypalInviteSignup();
    });
    if ($("#user_invite_code").val() !== "") {
      togglePaypalInviteSignup();
    }
    $('.input.ghostwrite').each(function() {
      var attr, css, hidden, input, oldv, span, update, write, _i, _len, _ref;
      input = $('input', this);
      span = $('span.ghost', this);
      write = $('span.write', this);
      css = {
        display: "none",
        top: input.position().top + 18,
        left: input.position().left + 8
      };
      _ref = ["font-family", "font-size"];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        attr = _ref[_i];
        css[attr] = input.css(attr);
      }
      span.css(css).click(function() {
        return input.focus();
      });
      hidden = true;
      oldv = input.val();
      update = function() {
        var v;
        v = input.val();
        if (v === oldv) {
          return;
        }
        oldv = v;
        if (v !== "") {
          write.html(v);
          if (hidden) {
            span.show();
            return hidden = false;
          }
        } else {
          hidden = true;
          return span.hide();
        }
      };
      return setInterval(update, 25);
    });
    mpq.push(['track_links', $("a.sign_up"), "Sign Up button clicked"]);
    mpq.push([
      'track_links', $("header nav a")[0], "Learn more nav link clicked", {
        nav_link: true
      }
    ]);
    mpq.push([
      'track_links', $("header nav a")[1], "FAQ nav link clicked", {
        nav_link: true
      }
    ]);
    mpq.push([
      'track_links', $("header nav a")[2], "Twitter nav link clicked", {
        nav_link: true
      }
    ]);
    mpq.push([
      'track_links', $("header h1 > a"), "Logo link clicked", {
        nav_link: true
      }
    ]);
    user_email = $("#new_user #user_email");
    mask_email = $("#new_user #user_mask_email_name");
    summary_freq_selector = "#new_user input:radio[name=user[summary_frequency]]";
    invite_code = $("#new_user #user_invite_code");
    getSignupProps = function() {
      return {
        user_email: user_email.val(),
        mask_email: mask_email.val(),
        summary_frequency: $("" + summary_freq_selector + ":checked").val(),
        invite_code: invite_code.val(),
        invite_used: $("#invite_code_input").css('display') === "block"
      };
    };
    user_email.change(function(e) {
      return mpq.push(['track', "User's own email filled out", getSignupProps()]);
    });
    mask_email.change(function(e) {
      return mpq.push(['track', "User's mask email filled out", getSignupProps()]);
    });
    $(summary_freq_selector).change(function(e) {
      return mpq.push(['track', "User's summary frequency filled out", getSignupProps()]);
    });
    return invite_code.change(function(e) {
      return mpq.push(['track', "User's invite code filled out", getSignupProps()]);
    });
  });
}).call(this);
