$(document).ready ->
  #$('body').noisy
    #intensity: 1
    #size: 200
    #opacity: 0.08
    #fallback: '/images/bg.png'
    #monochrome: false
  
  #$('form#new_user').validate
    #debug: true
    #errorElement: "span"

  $('.input.ghostwrite').each () ->
    input = $('input', this)
    span = $('span.ghost', this)
    write = $('span.write', this)

    $(this).css
      position: "relative"

    css =
      position: "absolute"
      top: "4px"
      left: "2px"
      display: "none"
      color: "#888"
    
    for attr in ["font-family", "font-size", "padding-left", "padding-top"]
      css[attr] = input.css(attr)

    span.css(css).click ->
      input.focus()

    input.css(
      width: 248
    ).keyup( ->
      if input.val() != ""
        span.show()
        write.html(input.val())
      else
        span.hide()
    ).trigger('keyup')

    true
