class InterfaceErrorMailer < MultiplexMailer
  default :from => "Othermail Errors <support@#{Multiplex::Application::Domain}>"
  layout 'email'

  def error(type, to)
    @from_user = to
    mail(:to => to, :subject => "Othermail Error! Uh oh.", 'List-Help' => "<mailto:help@othermail.me>") do |format|
      format.html { render type.to_s }
      format.text { render type.to_s }
    end
  end
end
