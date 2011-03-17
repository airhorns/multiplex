(function() {
  $(document).ready(function() {
    return $('.input.ghostwrite').each(function() {
      var attr, css, input, span, write, _i, _len, _ref;
      input = $('input', this);
      span = $('span.ghost', this);
      write = $('span.write', this);
      $(this).css({
        position: "relative"
      });
      css = {
        position: "absolute",
        top: "4px",
        left: "2px",
        display: "none",
        color: "#888"
      };
      _ref = ["font-family", "font-size", "padding-left", "padding-top"];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        attr = _ref[_i];
        css[attr] = input.css(attr);
      }
      span.css(css).click(function() {
        return input.focus();
      });
      input.css({
        width: 248
      }).keyup(function() {
        if (input.val() !== "") {
          span.show();
          return write.html(input.val());
        } else {
          return span.hide();
        }
      }).trigger('keyup');
      return true;
    });
  });
}).call(this);
