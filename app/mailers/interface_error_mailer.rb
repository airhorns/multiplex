class InterfaceErrorMailer < ActionMailer::Base
  default :from => "OtherBox Errors <support@#{Multiplex::Application::Domain}>"
  layout 'email'

  def error(type, to)
    @from_user = to
    mail(:to => to, :subject => "Otherbox Error! Uh oh.") do |format|
      format.html { render type.to_s }
      format.text { render type.to_s }
    end
  end
end
