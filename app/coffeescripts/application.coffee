$(document).ready ->
  $('body').noisy
    intensity: 1
    size: 200
    opacity: 0.08
    fallback: '/images/bg.png'
    monochrome: false
  
  #$('form#new_user').validate
    #debug: true
    #errorElement: "span"
