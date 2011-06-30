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

  # Track signup links
  mpq.push ['track_links', $("a.sign_up"), "Sign Up button clicked"]

  # Track nav links
  mpq.push ['track_links', $("header nav a")[0], "Learn more nav link clicked", {nav_link: true}]
  mpq.push ['track_links', $("header nav a")[1], "FAQ nav link clicked", {nav_link: true}]
  mpq.push ['track_links', $("header nav a")[2], "Twitter nav link clicked", {nav_link: true}]
  mpq.push ['track_links', $("header h1 > a"), "Logo link clicked", {nav_link: true}]

  # Track signup flow
  user_email = $("#new_user #user_email")
  mask_email = $("#new_user #user_mask_email_name")
  summary_freq_selector = "#new_user input:radio[name=user[summary_frequency]]" 
  invite_code = $("#new_user #user_invite_code")

  getSignupProps = ->
    user_email: user_email.val()
    mask_email: mask_email.val()
    summary_frequency: $("#{summary_freq_selector}:checked").val()
    invite_code: invite_code.val()
    invite_used: $("#invite_code_input").css('display') == "block"

  user_email.change (e) ->
    mpq.push ['track',  "User's own email filled out", getSignupProps()]

  mask_email.change (e) ->
    mpq.push ['track',  "User's mask email filled out", getSignupProps()]

  $(summary_freq_selector).change (e) ->
    mpq.push ['track',  "User's summary frequency filled out", getSignupProps()]

  invite_code.change (e) ->
    mpq.push ['track',  "User's invite code filled out", getSignupProps()]
