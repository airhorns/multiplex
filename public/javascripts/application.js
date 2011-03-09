(function() {
  $(document).ready(function() {
    return $('body').noisy({
      intensity: 1,
      size: 200,
      opacity: 0.08,
      fallback: '/images/bg.png',
      monochrome: false
    });
  });
}).call(this);
