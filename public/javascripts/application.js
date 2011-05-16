(function() {
  $(document).ready(function() {
    return $('.input.ghostwrite').each(function() {
      var attr, css, hidden, input, span, write, _i, _len, _ref;
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
      input.keyup(function(e) {
        var v;
        v = input.val();
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
      }).trigger('keyup');
      return true;
    });
  });
}).call(this);
