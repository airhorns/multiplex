class InterfaceErrorMailer < ActionMailer::Base
  default :from => "OtherBox Errors <support@#{Multiplex::Application::Domain}>"

  def error(path, message)

  end
end
