$(document).ready ->
  togglePaypalInviteSignup = ->
    $('.basement .paypal, .basement .invite, #invite_code_input').toggle()

  $('#use_invite, #use_paypal').click (e) ->
    e.preventDefault()
    togglePaypalInviteSignup()

  if $("#user_invite_code").val() != ""
    togglePaypalInviteSignup()

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
    oldv = input.val()
    update = () ->
      v = input.val()
      return if v == oldv
      oldv = v
      if v != ""
        write.html(v)
        if hidden
          span.show()
          hidden = false
      else
        hidden = true
        span.hide()
    setInterval(update, 25)

    true
