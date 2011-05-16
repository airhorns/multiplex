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

    css =
      display: "none"
      top: input.position().top + 18
      left: input.position().left + 8
    
    for attr in ["font-family", "font-size"]
      css[attr] = input.css(attr)

    span.css(css).click ->
      input.focus()
    
    hidden = true
    input.keyup( (e) ->
      v = input.val()
      if v != ""
        write.html(v)
        if hidden
          span.show()
          hidden = false
      else
        hidden = true
        span.hide()
    ).trigger('keyup')

    true
