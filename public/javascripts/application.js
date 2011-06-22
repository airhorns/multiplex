(function() {
  $(document).ready(function() {
    var togglePaypalInviteSignup;
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
    return $('.input.ghostwrite').each(function() {
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
      setInterval(update, 25);
      return true;
    });
  });
}).call(this);
