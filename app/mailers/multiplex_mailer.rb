class MultiplexMailer < ActionMailer::Base
  def mail(headers = {}, &block)
    message = super(headers, &block)
    premailer = Premailer.new(message.html_part.body.to_s.html_safe, {:with_html_string => true})
    message.html_part.body = premailer.to_inline_css.html_safe
    message
  end
end
